# #contest_doc
# name Similar_but_Different_Ways（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cj
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template

input:
  (N,Q): int
  A: seq[int]
  XY[Q]: (int1, int1)

dmp A

var g = initGraph(N)
for i in Q:
  g.addBiEdge(XY[i][0], XY[i][1])

var
  exist = initTable[int,Deque[int]]()
  chosen = initDeque[int]()
  ngcnt = makeSeq([N],0)
  acc = 0
  ans = 0

proc dfs(target: int): bool =
  if target >= N:
    dmp (acc,chosen)
    if exist.hasKey(acc) and acc != 0:
      ans = acc
      return true # stop
    exist[acc] = chosen
    return false
  
  if dfs(target+1): return true

  if ngcnt[target] > 0: return

  for e in g.adj[target]: ngcnt[e.dst].inc
  acc += A[target]
  chosen.addLast target

  if dfs(target+1): return true

  for e in g.adj[target]: ngcnt[e.dst].dec
  acc -= A[target]
  discard chosen.popLast

discard dfs(0)

dmp ans
dmp chosen
echo chosen.len
echo chosen.mapIt($(it+1)).join(" ")
dmp exist[ans]
echo exist[ans].len
echo exist[ans].mapIt($(it+1)).join(" ")
