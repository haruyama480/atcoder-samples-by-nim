# #contest_doc
# name Many_Graph_Queries（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bg
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/graph/graph_template

input:
  (N,M,Q): int
  XY[M]: (int1,int1)
  AB[Q]: (int1,int1)

# var g = initGraph(N)
# for i in M: g.addEdge(XY[i][0], XY[i][1])
var g = makeSeq([N,0],0)
for i in M: g[XY[i][0]].add XY[i][1]

var
  dp = makeSeq([N], 0u64)
  start = 0
while true:
  let endd = min(start+64,Q)
  if start == endd: break

  dp.fill(0u64)
  for idx in start..<endd:
    dp[AB[idx][0]] |= 1u64 shl (idx-start)

  for i in N:
    # for e in g.adj[i].mitems():
    #   dp[e.dst] |= dp[i]
    for e in g[i].mitems(): # mitmes for fast iteration
      dp[e] |= dp[i]
  
  for idx in start..<endd:
    if (dp[AB[idx][1]].bitand(1u64 shl (idx-start))) > 0u64:
      echo "Yes"
    else:
      echo "No"

  start = min(start+64,Q)
