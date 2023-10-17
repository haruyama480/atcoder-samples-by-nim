import code
import sys

from cached_property import cached_property
from fabric import task

sys.path.append('atcoder')
from tools.command import create_act  # nopep8


@task
def render(_, cid=None, cnum=None, ig_tids=None, ex_tids=None):
    assert cid is not None
    act = create_act(cid, cnum)
    act.render_dir(ig_tids=ig_tids, ex_tids=ex_tids)


@task
def submit(_, cid=None, cnum=None, tid=None):
    assert tid is not None
    act = create_act(cid, cnum)
    act.submit_nim(tid)


class Helper():
    def __init__(self, task) -> None:
        self.oneof_task = task

    def __repr__(self):
        disc = f'''
usage:
act.render_dir(ex_tids='{self.oneof_task}')
act.submit_cp('{self.oneof_task}')
act.submit_py('{self.oneof_task}')
act.submit_rs('{self.oneof_task}')
act.submit_nim('{self.oneof_task}')
'''.strip()
        return disc


@task
def open(_, cid=None, cnum=None, ig_tids=None, ex_tids=None):
    '''
    usage: fab open --cid abc --cnum 111 --ex-tids e,f
    cid: contest id. ex) abc, typical90
    cnum: (optional) contest num. ex) 023
    ig-tids: (optional) ignore rendering given tasks. ex) a,b,c
    ex-tids: (optional) exclusive rendering other tasks. ex) a,b,c
    '''
    if (cid is None):
        help()
        return

    act = create_act(cid, cnum)
    act.render_dir(ig_tids=ig_tids, ex_tids=ex_tids)
    h = Helper(act.game_tasks[0])

    # enable compleion
    import readline
    import rlcompleter
    vars = locals()
    readline.set_completer(rlcompleter.Completer(vars).complete)
    readline.parse_and_bind("tab: complete")
    code.InteractiveConsole(vars).interact()
