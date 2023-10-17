# #contest_doc
# name Preserve_Connectivity（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ai
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/doubling_lowest_common_ancestor

input:
  N: int
  AB[N-1]: (int1, int1)
  Q: int
  KV[Q]: seq[int]

var g = initGraph(N)
for i in N - 1: g.addBiEdge(AB[i][0], AB[i][1])
let glca = initDoublingLowestCommonAncestor(g, 0)

cnt := 0
n2p := makeSeq([N], -1)
p2n := makeSeq([N], -1)
proc dfs(target: int) =
  n2p[target] = cnt
  p2n[cnt] = target
  cnt.inc
  for e in g.adj[target]:
    nx := e.dst
    if n2p[nx] >= 0: continue
    dfs(nx)
dfs(0)

proc dist(x,y: int): int =
  lcaaa := glca.lca(x,y)
  glca.dep[x] + glca.dep[y] - glca.dep[lcaaa] * 2

for q in Q:
  K := KV[q][0]
  ps := makeSeq([K], 0)
  for k in K:
    ps[k] = n2p[KV[q][k+1]-1]
  ps.sort()
  ps.add(ps[0])
  ans := 0
  for i in K:
    ans += dist(p2n[ps[i]],p2n[ps[i+1]])
  echo ans div 2
