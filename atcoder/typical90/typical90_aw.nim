# #contest_doc
# name Flip_Digits_2（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_aw
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/prim

input:
  (N,M): int
  CLR[M]: (int,int1,int)

var g = initGraph(N+1)
for i in M: g.addBiEdge(CLR[i][1],CLR[i][2],CLR[i][0])

var (total, tree) = g.prim
if tree.len == N:
  echo total
else:
  echo -1
