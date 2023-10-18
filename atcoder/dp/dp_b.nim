# #contest_doc
# name Frog_2
# url https://atcoder.jp/contests/dp/tasks/dp_b
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
  h: seq[int]

var dp = makeSeq([N],10i64^10)
dp[0] = 0
for i in 1..<N:
  for k in 1..K:
    if i-k >= 0:
      dp[i].min= dp[i-k]+abs(h[i]-h[i-k])
echo dp[^1]
