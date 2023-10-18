# #contest_doc
# name Takahashi_Number（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bb
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

input:
  (N,M): int
var RR = collect(newSeq):
  for i in M:
    input:
      _: int
      rr: seq[int1]
    rr

var g = initGraph(N+M)
for m in M:
  for r in RR[m]:
    g.addBiEdge(N+m,r)

var dist = g.dijkstra(0)
dmp dist

for i in N:
  let d = dist[i]
  if d < 10^7: echo d div 2
  else:        echo -1
