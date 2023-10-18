# #contest_doc
# name Simple_Grouping（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_as
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
  XY[N]: (int, int)

X := XY.mapIt(it[0])
Y := XY.mapIt(it[1])
maxDist := newSeq[int](2^N)

for S in 1..<(1 shl N):
  bits := bitvals(S,N)
  maxDist[S] = maxDist[S - (1 shl bits[0])]
  for i in 1..<bits.len:
    maxDist[S].max= ((X[bits[0]] - X[bits[i]])^2 + (Y[bits[0]] - Y[bits[i]])^2)

dp := makeSeq([2^N, N], 10^18)
dp[0].fill(0)
for S in 1..<(1 shl N):
  for i in 1..K:
    for T in S.subbits:
      dp[S][i].min= max(dp[S-T][i-1], maxDist[T])
echo dp[(1 shl N) - 1][K]
