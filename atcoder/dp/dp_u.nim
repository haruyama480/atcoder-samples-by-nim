# #contest_doc
# name Grouping
# url https://atcoder.jp/contests/dp/tasks/dp_u
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  A[N]: seq[int64]

var score = makeSeq([2^N], 0i64)
for S in 2^N:
  for i in N:
    for j in i:
      if S.bits(i) and S.bits(j):
        score[S] += A[i][j]

var dp = score
for i in N-1:
  for S in 1..<2^N:
    var T = S.bitand(S-1)
    while T > 0:
      dp[S].max= dp[S.bitxor(T)] + score[T]
      T = S.bitand(T-1)
echo dp[2^N-1]

# var dp = makeSeq([N, 2^N], -10i64^17)
# dp[0] = score
# for i in N-1:
#   for S in 1..<2^N:
#     var T = S.bitand(S-1)
#     while T > 0:
#       dp[i+1][S].max= dp[i][S.bitxor(T)] + score[T]
#       T = S.bitand(T-1)
# echo dp.mapIt(it[2^N-1]).max
