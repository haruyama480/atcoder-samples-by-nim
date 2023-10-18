# #contest_doc
# name Coins
# url https://atcoder.jp/contests/dp/tasks/dp_i
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  p: seq[float]

var dp = makeSeq([N+1,N+1],0.0)
dp[0][0] = 1
for i in N:
  for j in 0..i:
    dp[i+1][j] += dp[i][j] * p[i]
    dp[i+1][j+1] += dp[i][j] * (1-p[i])
echo dp[^1][0..(N div 2)].sum
