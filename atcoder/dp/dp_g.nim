# #contest_doc
# name Longest_Path
# url https://atcoder.jp/contests/dp/tasks/dp_g
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/topological_sort

input:
  (N,M): int
  xy[M]: (int1,int1)

var g = initGraph(N)
for i in M: g.addEdge(xy[i][0], xy[i][1])

let topo = g.topologicalSort
var dp = makeSeq([N], 0)
for i in N:
  for e in g[topo[i]]:
    dp[e.dst].max= dp[topo[i]] + 1
echo dp.max
