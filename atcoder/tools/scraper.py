import time
from typing import Dict, List, Tuple

import lxml.html
from cached_property import cached_property
from matplotlib.pyplot import title

from tools.api import AtCoderApi


class AtCoderTask(object):
    task_id: str
    title: str
    url: str
    testcases: List[Tuple[str, str]]  # [(in_text, out_txt)]

    def __init__(self) -> None:
        self.testcases = []

    def __repr__(self) -> str:
        return repr(
            {
                "task_id": self.task_id,
                "title": self.title,
                "url": self.url,
                "testcases": self.testcases,
            }
        )


class AtCoderContest(object):
    tasks: Dict[str, AtCoderTask]  # {task_id, AtCoderTask}
    order: List[str]  # [task_id]

    def __init__(self) -> None:
        self.tasks = {}
        self.order = []

    def __repr__(self) -> str:
        return repr(
            {
                "tasks": self.tasks,
                "order": self.order,
            }
        )


class AtCoderScraper(object):
    """
    渡されたApiクラスを使って得たレスポンスから、問題情報を抽出するクラス。
    AtCoderの様々なコンテストに適用しやすいように書く。
    """

    def __init__(self, api, contest_id):
        """
        :param api: AtCoderApi
        :param contest_id: first 'abc170' of 'https://atcoder.jp/contests/abc170/tasks/{task_id}'
        """
        self.api: AtCoderApi = api
        self.contest_id = contest_id

        self.xpath_title = "//title/text()"
        # self.xpath_testcases = "//span[@class='lang-ja']/div/section/pre[contains(@id,'sample')]/text()"
        self.xpath_testcases = "//span[@class='lang-ja']/div/section/pre"

    @cached_property
    def tasks(self) -> List[str]:
        """
        get task list
        :return: like ['abc111_a', 'abc111_b', ..]
        """
        return self.api.get_task_ids(self.contest_id)

    def run(self, request_interval_sec, ex_tilds: List[str] = None) -> AtCoderContest:
        """
        :param request_interval_sec:
        :param ex_tilds: no skip task. if not given, all tasks will be scraped.
        :return: multiple task info. ({task_id: (title, url, [(in_txt, out_txt)])}, [task_id])
        """
        ts = AtCoderContest()
        ts.order = self.tasks
        for key in self.tasks:
            if ex_tilds is not None and key not in ex_tilds:
                continue
            # 高負荷にならないように直列でリクエスト
            ts.tasks[key] = self._scrape_task(key)
            time.sleep(request_interval_sec)

        return ts

    def _scrape_task(self, task_id) -> AtCoderTask:
        """
        :param task_id: like 'abc111_a'
        :return: one task info. (title, url, [(in_txt, out_txt)])
        """
        t = AtCoderTask()
        t.task_id = task_id

        response = self.api.get_task(
            self.contest_id, task_id)

        dom = lxml.html.fromstring(response.content)
        title_raw = dom.xpath(self.xpath_title)[0].split()[2:]
        t.title = "_".join(title_raw)  # for making parse easy in future

        t.url = response.url

        test_seq = dom.xpath(self.xpath_testcases)
        # NOTE: 頭に改行が入ることがあったので lstrip
        ins = [txt.text_content().lstrip()
               for i, txt in enumerate(test_seq) if i % 2 == 0]
        outs = [txt.text_content().lstrip()
                for i, txt in enumerate(test_seq) if i % 2 == 1]

        t.testcases = list(zip(ins, outs))

        return t


if __name__ == '__main__':
    from pprint import pprint
    api = AtCoderApi()
    # api.login('username', 'password')

    sc = AtCoderScraper(api, contest_id='arc106')
    result = sc.run(request_interval_sec=0)

    pprint(result)
