# #contest_doc
# name Knapsack_1
# url https://atcoder.jp/contests/dp/tasks/dp_d
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,W): int
  wv[N]: (int,int64)

var dp = makeSeq([W+1],0.int64) # 重さiの時の最大の価値
for i in N:
  var (w,v) = wv[i]
  for j in 0..W << 1:
    if j - w >= 0:
      dp[j].max= dp[j-w]+v
echo dp[W]
