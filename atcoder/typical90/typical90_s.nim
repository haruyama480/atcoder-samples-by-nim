# #contest_doc
# name Pick_Two（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_s
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  N: int
  A: seq[int]

var
  # dp[i][j]: i から j までのコストの最小値
  dp = makeSeq([2*N, 2*N], -1)

proc rec(x, y: int): int =
  if x >= y:
    return 0
  if dp[x][y] >= 0:
    return dp[x][y]

  result = int.high
  # x のペアを x+1 から y まで試す. x,yは2の倍数しかありえない
  for i in countup(x+1, y, 2):
    result.min = abs(A[x] - A[i]) + rec(x+1, i-1) + rec(i+1, y)
  dp[x][y] = result

echo rec(0, 2*N-1)
