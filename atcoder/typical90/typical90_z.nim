# #contest_doc
# name Independent_Set_on_a_Tree（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_z
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template

input:
  N: int
  AB[N-1]: (int1, int1)

var g = initGraph(N)
for i in N - 1: g.addBiEdge(AB[i][0], AB[i][1])

var p1 = toHashSet[int]([])
var p2 = toHashSet[int]([])

proc dfs(target, parity: int) =
  if parity == 0:
    p1.incl(target)
  else:
    p2.incl(target)

  for e in g.adj[target]:
    let d = e.dst
    if p1.contains(d) or p2.contains(d):
      continue
    dfs(d, (parity + 1) mod 2)

dfs(0, 0)

proc ans(s: HashSet[int]) =
  echo s.toSeq[0..<(N div 2)].mapIt(it+1).join(" ")

if p1.len >= p2.len:
  ans p1
else:
  ans p2
