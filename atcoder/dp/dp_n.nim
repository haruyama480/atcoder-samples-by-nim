# #contest_doc
# name Slimes
# url https://atcoder.jp/contests/dp/tasks/dp_n
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/dp/cumulative_sum

input:
  N: int
  A: seq[int64]

const inf = 10i64^18
var dp = makeSeq([N,N+1],inf) # [i..j)のコストの最小値
var cum = initCumulativeSum[int64](A)

proc f(i,j: int):int64=
  if j-i<=1: return 0
  if dp[i][j] != inf: return dp[i][j]
  for d in j-i-1:
    dp[i][j].min= cum[i..<j] + f(i,i+1+d) + f(i+1+d, j)
  return dp[i][j]

echo f(0,N)
