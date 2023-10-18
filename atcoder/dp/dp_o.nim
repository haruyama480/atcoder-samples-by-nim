# #contest_doc
# name Matching
# url https://atcoder.jp/contests/dp/tasks/dp_o
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint
type mint = modint1000000007

input:
  N: int
  A[N]: seq[int]

var dp = makeSeq([2^N], 0.mint)
# dp[i][S] = sum_j(dp[i-1][S^(1<<j)] if a[i][j])

dp[0] = 1
for S in 1..<2^N:
  let i = S.popcount-1
  for j in N:
    if A[i][j] > 0 and S.bits(j):
      dp[S] += dp[S.bitxor(1 shl j)]
echo dp[^1]