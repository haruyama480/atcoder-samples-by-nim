# #contest_doc
# name Knapsack_2
# url https://atcoder.jp/contests/dp/tasks/dp_e
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,W): int
  wv[N]: (int,int64)

let MAXV = 10^3*N + 1
const inf = 10^9 + 10
var dp = makeSeq([MAXV], inf) # 価値vを実現する最小のw
dp[0] = 0
for i in N:
  for j in 0..<MAXV << 1:
    let (w,v) = wv[i]
    if j - v >= 0:
      dp[j].min= dp[j-v] + w
echo dp.zipWithIndices.filterIt(it[1]<=W).mapIt(it[0]).max