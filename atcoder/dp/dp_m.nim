# #contest_doc
# name Candies
# url https://atcoder.jp/contests/dp/tasks/dp_m
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/dp/cumulative_sum
import atcoder/modint
type mint = modint1000000007

input:
  (N,K): int
  A: seq[int]

var dp = makeSeq([N+1,K+1], 0.mint) # dp[i][j] [1..i]の子にj個の飴を配る通り数

dp[0][0] = 1
for i in 1..N:
  var cum = initCumulativeSum[mint](dp[i-1])
  for j in 0..K:
    if j-A[i-1] >= 0:
      dp[i][j] = cum[j-A[i-1]..j] # dp[i-1][j-a[k]..j]
    else:
      dp[i][j] = cum[0..j]

echo dp[N][K]
