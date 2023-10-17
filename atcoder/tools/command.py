import getpass
import pathlib
import webbrowser
from datetime import datetime
from fileinput import filename
from typing import Dict, List, Tuple

from cached_property import cached_property

from tools.api import AtCoderApi
from tools.scraper import AtCoderContest, AtCoderScraper, AtCoderTask
from tools.template import Template, TemplateNim, TemplateRs

USERNAME = getpass.getuser()

class AtCoderTool:
    def __init__(self, api, scraper, template_dir: str, game_dir: pathlib.Path):
        self._api: AtCoderApi = api
        self._scraper: AtCoderScraper = scraper
        self._template = Template(template_dir)
        self._template_nim = TemplateNim(template_dir)
        self._game_dir: pathlib.Path = game_dir

        self._path_template_filename = "{task_id}"
        self._path_template_testcases_in = "test/{task_id}.cases/{case_i}.in"
        self._path_template_testcases_out = "test/{task_id}.cases/{case_i}.out"
        self._path_test_script = "test/exec.sh"
        self._path_nim_cfg = "nim.cfg"
        self._path_nim_combined = "test/combined.nim"

    @cached_property
    def game_tasks(self) -> AtCoderContest:
        tasks = self._scraper.tasks
        return tasks

    @cached_property
    def game_contest(self) -> AtCoderContest:
        contest = self._scraper.run(request_interval_sec=0)
        return contest

    def render_dir(self, ig_tids=None, ex_tids=None):
        """
        ig_tids: string like 'a,b,c'
        ex_tids: string like 'a,b,c'
        """

        def targetTask(task_id: str) -> bool:
            """
            task_id が render対象か判定する
            """
            # implementation detail: ig_tids, ex_tidsどちらも指定される場合は ig が優先される
            if ig_tids is not None:
                return not task_id in ig_tids
            if ex_tids is not None:
                return task_id in ex_tids
            return True

        contest: AtCoderContest = self._scraper.run(
            request_interval_sec=0, ex_tilds=ex_tids)
        for task_id in contest.order:
            if not targetTask(task_id):
                continue
            self._create_shellscript(task_id, exist_ok=True)
            self._create_testcases(
                task_id, contest.tasks[task_id], exist_ok=True)
            self._create_nim(task_id, contest.tasks[task_id], exist_ok=False)
        self._create_nim_cfg(exist_ok=False)

    def _prepare_path(self, path, exist_ok):
        """
        ファイルを書き込むまえに、すでにファイルが存在するか確認し、
        存在しなければ親ディレクトリを作成しておく関数
        """
        path.parent.mkdir(parents=True, exist_ok=True)
        if path.exists() and exist_ok is False:
            return False
        else:
            return True

    def _create_shellscript(self, task_id, exist_ok=False):
        """
        :param exist_ok: Trueなら上書きする
        """
        path = self._game_dir.joinpath(self._path_test_script)
        if self._prepare_path(path, exist_ok):
            self._template.render_shell(path)
        else:
            print("already file exists:", path)
            print("[_create_shellscript skipped]")

    def _create_nim_cfg(self, exist_ok=False):
        """
        :param exist_ok: Trueなら上書きする
        """
        path = self._game_dir.joinpath(self._path_nim_cfg)
        if self._prepare_path(path, exist_ok):
            self._template_nim.render_cfg(path)
        else:
            print("already file exists:", path)
            print("[_create_nim_cfg skipped]")

    def _create_nim(self, task_id, task: AtCoderTask, exist_ok=False):
        """
        :param exist_ok: Trueなら上書きする
        """
        file_name = self._path_template_filename.format(task_id=task_id)
        path = self._game_dir.joinpath(file_name).with_suffix(".nim")

        if self._prepare_path(path, exist_ok):
            self._template_nim.render_nim(path, task.title, task.url)
        else:
            print("already file exists:", path)
            print("[creat_rs skipped]")

    def _create_testcases(self, task_id, task: AtCoderTask, exist_ok=False):
        """
        :param exist_ok: Trueなら上書きする
        """
        for case_i, (in_txt, out_txt) in enumerate(task.testcases):
            # in
            file_name = self._path_template_testcases_in.format(
                task_id=task_id, case_i=case_i)
            path = self._game_dir.joinpath(file_name)
            if not self._prepare_path(path, exist_ok):
                print("already file exists:", path)
                print("[_create_testcases skipped]")
                return

            with open(path, 'w+') as f:
                f.write(in_txt)

            # out
            file_name = self._path_template_testcases_out.format(
                task_id=task_id, case_i=case_i)
            path = self._game_dir.joinpath(file_name)
            with open(path, 'w+') as f:
                f.write(out_txt)

    def submit(self, task_id, lang):
        sc = self._scraper

        # 参考: https://atcoder.jp/contests/abc001/submit?taskScreenName=abc001_1
        # 上のurlを開き、開発者コンソールで「(//div[@id='select-lang']//select)[1]/option」を検索
        # ver数が異なることがあるのでprefixで判定する
        lang_prefix = ""
        source_code = ""

        file_name = self._path_template_filename.format(task_id=task_id)
        if lang == "nim":
            lang_prefix = "Nim ("
            target_path = self._game_dir.joinpath(file_name).with_suffix(".nim")
            import subprocess

            # first expand
            combined_path = self._game_dir.joinpath(self._path_nim_combined)
            result = subprocess.run(["python3", f"/Users/{USERNAME}/ghq/github.com/haruyama480/atcoder-samples-by-nim/nim/expander.py",
                                     "-s", target_path, "-c"], capture_output=True)
            assert result.returncode == 0, result
            with open(combined_path, 'w') as f:
                f.write(result.stdout.decode())
            # second expand
            result = subprocess.run(["python3", f"/Users/{USERNAME}/ghq/github.com/zer0-star/Nim-ACL/expander.py",
                                     "--lib", f"/Users/{USERNAME}/ghq/github.com/zer0-star/Nim-ACL",
                                     "-s", combined_path, "-c"], capture_output=True)
            assert result.returncode == 0, result
            source_code = result.stdout.decode()
            with open(combined_path, 'w') as f:
                f.write(source_code)
            # compile check
            result = subprocess.run(
                ["nim", "cpp", "--out:/dev/null", str(combined_path)], capture_output=True)
            assert result.returncode == 0, result.stderr.decode()
        else:
            if lang == "cp":
                lang_prefix = "C++ (GCC"
                path = self._game_dir.joinpath(file_name).with_suffix(".cpp")
            elif lang == "py":
                lang_prefix = "Python (3"
                path = self._game_dir.joinpath(file_name).with_suffix(".py")
            elif lang == "pypy":
                lang_prefix = "PyPy3"
                path = self._game_dir.joinpath(file_name).with_suffix(".py")
            elif lang == "rs":
                lang_prefix = "Rust ("
                path = self._game_dir.joinpath(file_name).with_suffix(".rs")
            else:
                raise Exception('invalid lang id, ' + lang)
            with open(path, 'r') as f:
                source_code = f.read()

        submission_id = self._api.submit(contest_id=sc.contest_id,
                                         task_id=task_id,
                                         lang_prefix=lang_prefix,
                                         source_code=source_code)
        assert int(submission_id)

        # url = 'https://atcoder.jp/contests/%s/submissions/%s' % (sc.contest_id, submission_id)
        url = 'https://atcoder.jp/contests/%s/submissions/me' % sc.contest_id
        chrome_path = 'open -a /Applications/Google\ Chrome.app %s'
        webbrowser.get(chrome_path).open(url)
        # 下のプラグインを入れると、ジャッジ後push通知してくれる
        # https://chrome.google.com/webstore/detail/comfortable-atcoder/ipmmkccdccnephfilbjdnmnfcbopbpaj?hl=ja

    def submit_cp(self, char):
        self.submit(char, 'cp')

    def submit_py(self, char):
        self.submit(char, 'py')

    def submit_rs(self, char):
        self.submit(char, 'rs')

    def submit_nim(self, char):
        self.submit(char, 'nim')


def create_act(contest_class, contest_num=None):
    base = f'/Users/{USERNAME}/ghq/github.com/haruyama480/atcoder-samples-by-nim/'
    root_dir = pathlib.Path(f'{base}/atcoder')
    template_dir = f'{base}/atcoder/tools/templates'

    if contest_num is None:
        contest_id = contest_class
        game_dir = root_dir.joinpath(str(contest_class))
    else:
        contest_id = contest_class + str(contest_num)
        game_dir = root_dir.joinpath(str(contest_class), str(contest_num))

    api = AtCoderApi()
    api.login('haruyama480', getpass.getpass())
    sc = AtCoderScraper(api, contest_id)
    act = AtCoderTool(api, sc, template_dir, game_dir)
    return act


def sample():
    act = create_act('abc', '179')
    act.render_dir()
    # act.submit('a', 'cp')


if __name__ == '__main__':
    sample()
