# #contest_doc
# name Passing（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_m
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/dijkstra

input:
  (N, M): int
  ABC[M]: (int1, int1, int)

var g = initGraph(N)

for (a, b, c) in ABC:
  g.addEdge(a, b, c)
  g.addEdge(b, a, c)

var dist1 = g.dijkstra(0)
var distN = g.dijkstra(N-1)

for i in N:
  echo dist1[i] + distN[i]

# var
#   graph = newSeqWith(N, newSeq[(int, int)](0))
#   from1, fromN = newSeqWith(N, int.high)

# # 街0からkへの最短経路を求める
# block:
#   var
#     priq = initHeapQueue[(int, int)]()
#     locked = Seq[N: false]

#   from1[0] = 0
#   priq.push((0, 0))

#   while priq.len > 0:
#     let
#       (c, v) = priq.pop()

#     if locked[v]:
#       continue
#     locked[v] = true

#     for (w, d) in graph[v]:
#       if not locked[w] and from1[w] > c + d:
#         from1[w] = c + d
#         priq.push((c + d, w))

# # 街N-1からkへの最短経路を求める
# block:
#   var
#     priq = initHeapQueue[(int, int)]()
#     locked = Seq[N: false]

#   fromN[N-1] = 0
#   priq.push((0, N-1))

#   while priq.len > 0:
#     let
#       (c, v) = priq.pop()

#     if locked[v]:
#       continue
#     locked[v] = true

#     for (w, d) in graph[v]:
#       if not locked[w] and fromN[w] > c + d:
#         fromN[w] = c + d
#         priq.push((c + d, w))

# for i in N:
#   echo from1[i] + fromN[i]
