# #contest_doc
# name Planes_on_a_2D_Plane（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_by
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/maxflow

input:
  (N,T): int
  AXY[N]: (int64,int64)
  BXY[N]: (int64,int64)

let(start,goal) = (2*N, 2*N+1)
var mfg = initMFGraph[int](2*N + 2)
for i in N:
  mfg.addEdge(start,i,1)
  mfg.addEdge(i+N,goal,1)

var B = initTable[(int64,int64),int]()
for i in N: B[BXY[i]] = i

var dirs = initTable[(int,int),int]()
let dx = @[1,1,0,-1,-1,-1,0,1]
let dy = @[0,1,1,1,0,-1,-1,-1]
for i in N:
  for j in dx.len:
    let
      nx = AXY[i][0] + dx[j]*T
      ny = AXY[i][1] + dy[j]*T
    if not (nx in 0..10^9 and ny in 0..10^9): continue
    let p = (nx,ny)
    if B.hasKey(p):
      mfg.addEdge(i,B[p]+N,1)
      dirs[(i,B[p]+N)] = j

if N == mfg.flow(start,goal):
  echo "Yes"
  var ds = makeSeq([N],0)
  for e in mfg.edges:
    if e.src == start or e.dst == goal: continue
    if e.flow != 1: continue
    ds[e.src] = dirs[(e.src,e.dst)]
  echo ds.mapIt($(it+1)).join(" ")
else:
  echo "No"
