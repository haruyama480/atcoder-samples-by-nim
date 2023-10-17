# #contest_doc
# name We_Need_Both_a_and_b（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bu
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint
import atcoder/extra/graph/graph_template

type mint = modint1000000007
 
input:
  N: int
  C: seq[char]
  AB[N-1]: (int1, int1)
 
dmp N
dmp C
dmpi AB
 
var g = initGraph(N)
for i in N - 1: g.addBiEdge(AB[i][0], AB[i][1])
 
# dp カウント数
# 0: a,b両方含む枝
# 1: aしか含まない
# 2: bしか含まない
dp := makeSeq([3,N],mint(0))
 
proc tdp(now, par: int)=
  defer:
    dmp (now, dp[0][now],dp[1][now],dp[2][now])
 
  if C[now] == 'a':
    var all = mint(1)
    dp[1][now] = mint(1)
    for e in g.adj[now]:
      let c = e.dst
      if c == par: continue
      tdp(c, now)
      all *= 2*dp[0][c]+dp[1][c]+dp[2][c]
      dp[1][now] *= dp[0][c]+dp[1][c]
    dp[0][now] = all - dp[1][now]
  else:
    var all = mint(1)
    dp[2][now] = mint(1)
    for e in g.adj[now]:
      let c = e.dst
      if c == par: continue
      tdp(c, now)
      all *= 2*dp[0][c]+dp[1][c]+dp[2][c]
      dp[2][now] *= dp[0][c]+dp[2][c]
    dp[0][now] = all - dp[2][now]
 
tdp(0,-1)
 
echo dp[0][0]
