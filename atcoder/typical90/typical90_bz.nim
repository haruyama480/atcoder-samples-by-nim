# #contest_doc
# name Easy_Graph_Problem（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bz
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template

input:
  (N,M): int
  AB[M]: (int1, int1)
 
g := initGraph(N)
for i in M:
  g.addBiEdge(AB[i][0],AB[i][1])
 
proc ans(): int =
  for i in N:
    var cnt = 0
    for nx in g.adj[i]:
      if nx.dst < i:
        cnt.inc
    if cnt == 1:
      result.inc
 
echo ans()
 