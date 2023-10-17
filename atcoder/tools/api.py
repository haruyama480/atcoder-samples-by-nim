import lxml.html
import requests
from bs4 import BeautifulSoup


class AtCoderApi:
    """
    エンドポイントを叩くApiクラス。認証もやる。
    ABCだけでなくAtCoderのコンテスト全般に使えるように書く
    """

    def __init__(self):
        self.session = requests.session()

        # cache for debug
        self._response_login_get = None
        self._response_login_post = None
        self._response_submit_post = None
        self._lang_settings = None

        self.csrf_token = None

    def get_csrf_token(self):
        """
        :return: csrf_token
        """

        url = 'https://atcoder.jp/login'
        response = self.session.get(url)
        assert response.status_code == 200

        bs = BeautifulSoup(response.text, 'html.parser')
        self.csrf_token = bs.find(attrs={'name': 'csrf_token'}).get('value')

    def login(self, username, password):
        """
        ログインする関数。開催中のコンテストを見るにはログインが必要
        """

        self.get_csrf_token()

        # ログインリクエスト
        url = 'https://atcoder.jp/login'
        data = {
            "username": username,
            "password": password,
            "csrf_token": self.csrf_token,
        }
        response = self.session.post(url, data=data)
        assert response.status_code == 200
        self._response_login_post = response

        return self

    def get_task_ids(self, contest_id):
        """
        あるコンテストのtask_idをリストで返す
        # NOTE: task_id が contest_id を含むとは限らない
        :param contest_id: e.g. 'arc093' for https://atcoder.jp/contests/arc093/tasks
        # 例 https://atcoder.jp/contests/abs/tasks/abc086_a
        :return: e.g. ['practice_1', 'abc086_a', 'abc081_a', 'abc081_b', 'abc087_b', 'abc083_b', 'abc088_b', 'abc085_b', 'abc085_c', 'arc065_a', 'arc089_a']
        """

        base_url = 'https://atcoder.jp/contests/{contest_id}/tasks'
        url = base_url.format(contest_id=contest_id)
        response = self.session.get(url)
        assert response.status_code == 200

        xpath = "//tbody/tr/td[1]/a"
        dom = lxml.html.fromstring(response.content)
        elems = dom.xpath(xpath)

        task_ids = [e.get("href").split('/')[-1] for e in elems]
        assert not len(task_ids) == 0, 'not found tasks'
        return task_ids

    def get_task(self, contest_id, task_id):
        """
        :param contest_id: first 'abc170' of 'https://atcoder.jp/contests/abc170/tasks/{task_id}'
        :param task_id: like 'a' or 'f'
        :return:
        """
        base_url = 'https://atcoder.jp/contests/{contest_id}/tasks/{task_id}'
        url = base_url.format(contest_id=contest_id, task_id=task_id)
        response = self.session.get(url)

        code = response.status_code
        assert code == 200, 'status code %s. cannot get from %s' % (code, url)
        return response

    def submit(self, contest_id, task_id, lang_prefix, source_code):
        """
        問題提出用の関数
        :param contest_id:
        :param task_id:
        :param lang_prefix:
        :param source_code:
        :return:
        """

        # prepare csrf_token and lang settings
        url = 'https://atcoder.jp/contests/%s/submit' % contest_id
        response = self.session.get(url)
        assert response.status_code == 200
        bs = BeautifulSoup(response.text, 'html.parser')
        csrf_token = bs.find(attrs={'name': 'csrf_token'}).get('value')

        dom = lxml.html.fromstring(response.content)
        xpath = "(//div[@id='select-lang']//select)[1]/option"
        raw = dom.xpath(xpath)
        lang_settings = {i.text_content(): i.values(
        )[0] for i in raw if len(i.values()) > 0}
        self._lang_settings = lang_settings

        matches = [i for i in lang_settings.keys() if i.startswith(lang_prefix)]
        assert len(matches) == 1
        lang_id = lang_settings[matches[0]]

        # submit
        url = 'https://atcoder.jp/contests/%s/submit' % contest_id
        data = {
            "csrf_token": csrf_token,
            "data.TaskScreenName": task_id,
            "data.LanguageId": lang_id,
            "sourceCode": source_code,
        }
        response = self.session.post(url, data=data)
        self._response_submit_post = response
        assert response.status_code == 200

        dom = lxml.html.fromstring(response.content)
        xpath = "//tbody/tr[1]/td[last()]/a"
        elem = dom.xpath(xpath)[0]
        submission_id = elem.attrib['href'].split('/')[-1]
        assert int(submission_id)

        return submission_id
