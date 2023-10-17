# #contest_doc
# name Stair_Jump（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ax
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

type mint = modint1000000007
 
input:
  (N,L): int
 
dp := makeSeq([N+1],(mint)0)
 
dp[0] = 1
for i in N:
  if i+1 <= N : dp[i+1] += dp[i]
  if i+L <= N : dp[i+L] += dp[i]
 
echo dp[^1]
 