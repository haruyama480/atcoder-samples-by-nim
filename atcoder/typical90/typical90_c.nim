# #contest_doc
# name Longest_Circular_Road（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_c
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/tree_diameter

input:
  N: int
  AB[N-1]: (int1, int1)

var g = initGraph(N)
for i in N - 1: g.addBiEdge(AB[i][0], AB[i][1])
echo g.treeDiameter[0] + 1
