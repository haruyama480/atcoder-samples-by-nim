# #contest_doc
# name Walk
# url https://atcoder.jp/contests/dp/tasks/dp_r
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint
type mint = modint1000000007

input:
  (N,K): (int,int64)
  A[N]: seq[int]

proc mat_id(N: SomeInteger): seq[seq[mint]] =
  result = makeSeq([N,N], 0.mint)
  for i in N: result[i][i] = 1.mint

proc mat_mul[T](x,y: var seq[seq[T]]): auto= # var for speed 
  let N = x.len
  result = makeSeq([N,N], 0.T)
  for i in N:
    for j in N:
      for k in N:
        result[i][j] += x[i][k] * y[k][j]

# 最小2乗法
var dp = makeSeq([64,N,N],mint(0)) # dp[n][i][j]: iからjへの長さn-1のパスの通り数
dp[0] = A.mapIt(it.mapIt(it.mint))
for n in 1..<64:
  dp[n] = mat_mul(dp[n-1],dp[n-1])

proc ans(k: int64): seq[seq[mint]]= 
  result = mat_id(N)
  for b in 64:
    if k.bits(b):
      result = result.mat_mul(dp[b])

echo ans(K).mapIt(it.sum).sum