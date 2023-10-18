# #contest_doc
# name Paint_All（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bj
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template


input:
  N: int
  AB[N]: (int1,int1)

dmpi AB

var g = initGraph(N+1)
for i in N:
  var (A,B) = AB[i]
  if B==i: swap(A,B)
  if A==i:
    g.addEdge(N,A)
  else:
    g.addEdge(A,i)
  g.addEdge(B,i)

# Nからスタートして全網羅できるかどうか
queue := initDeque[int]()
visted := makeSeq([N+1], false)
trace := makeSeq([0], 0)

queue.addLast N
proc bfs()=
  while queue.len > 0:
    target := queue.popFirst
    if visted[target]: continue
    visted[target] = true
    trace.add target
    for e in g.adj[target]:
      queue.addLast e.dst
bfs()

if trace.len != N+1:
  echo -1 
else:
  trace.reverse
  dmp trace[0..^2].join(", ")
  echo trace[0..^2].mapIt(it+1).join("\n")
