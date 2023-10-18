# #contest_doc
# name Fuzzy_Priority（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bs
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/cycle_detection
import options

input:
  (N,M,K): int
  AB[M]: (int1, int1)

# キューの後ろからidx番目をpopする
func popIdx(q: var seq[int], idx: int): int {.inline.} =
  var buf = makeSeq([0],0)
  for _ in 0..<idx:
    buf.add q.pop()
  result = q.pop() 
  for _ in 0..<idx:
    q.add buf.pop()

# キューの後ろからidx番目にpushする
func pushIdx(q: var seq[int], idx: int, value: int) {.inline.} =
  var buf = makeSeq([0],0)
  for _ in 0..<idx:
    buf.add q.pop()
  q.add(value) 
  for _ in 0..<idx:
    q.add buf.pop()

proc solve()=
  var g = initGraph(N)
  for i in M: g.addEdge(AB[i][0], AB[i][1])

  if g.cycleDetection.isSome():
    echo -1
    return

  var 
    deg = makeSeq([N],0)
    trace = makeSeq([0],0)
    ans = makeSeq([0,0],0)
    cands = makeSeq([0],0)

  for i in 0..<N:
    for e in g[i]: deg[e.dst].inc

  for i in 0..<N:
    if deg[i] == 0: cands.add(i)

  proc dfs(target: int): bool=
    if trace.len == N:
      dmp trace
      ans.add trace
      if ans.len >= K: return true
    if cands.len == 0: return

    for l in cands.len:
      dmp (trace, target, cands)

      let c = cands.popIdx(l)

      var addcnt = 0
      for e in g[c]:
        deg[e.dst].dec
        if deg[e.dst] == 0:
          addcnt.inc; cands.add(e.dst)
      trace.add c

      if dfs(c): return true

      discard trace.pop
      for e in g[c]:
        deg[e.dst].inc
      while addcnt > 0:
        addcnt.dec; discard cands.pop

      cands.pushIdx(l,c)

  discard dfs(N)

  if ans.len >= K:
    for t in ans:
      echo t.mapIt($(it+1)).join(" ")
  else:
    echo -1

solve()
