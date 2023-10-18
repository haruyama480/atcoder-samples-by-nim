# #contest_doc
# name Independent_Set
# url https://atcoder.jp/contests/dp/tasks/dp_p
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/modint
type mint = modint1000000007

input:
  N: int
  XY[N-1]: (int1, int1)

var g = initGraph(N)
for i in N - 1: g.addBiEdge(XY[i][0], XY[i][1])

var dp = makeSeq([N,2],mint(1)) # 0:white, 1:black
proc dfs(t, par: int)=
  for c in g[t]:
    if c.dst == par: continue
    dfs(c.dst, t)
  
    dp[t][0] *= dp[c.dst][0] + dp[c.dst][1]
    dp[t][1] *= dp[c.dst][0]
dfs(0, -1)

echo dp[0].sum
