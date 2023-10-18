# #contest_doc
# name Frog_1
# url https://atcoder.jp/contests/dp/tasks/dp_a
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  h: seq[int]

var dp = makeSeq([N],10i64^10)
# dp[0] = 0
for i in 0..<N:
  if i == 0:
    dp[0] = 0
    continue
  dp[i].min= dp[i-1]+abs(h[i]-h[i-1])
  if i > 1:
    dp[i].min= dp[i-2]+abs(h[i]-h[i-2])
echo dp[^1]
