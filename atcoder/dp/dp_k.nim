# #contest_doc
# name Stones
# url https://atcoder.jp/contests/dp/tasks/dp_k
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
  A: seq[int]

var dp = makeSeq([K+1],false) # そのターンを迎えたら勝てるか
for i in 1..K:
  for j in N:
    let pre = i - A[j]
    if pre >= 0 and dp[pre]==false:
      dp[i]=true
if dp[K]:
  echo "First"
else:
  echo "Second"