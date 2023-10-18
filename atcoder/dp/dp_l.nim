# #contest_doc
# name Deque
# url https://atcoder.jp/contests/dp/tasks/dp_l
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  A: seq[int64]

const inf = 10i64^15
var dp = makeSeq([N,N],inf) # 区間[i..j]を迎えた時のスコア差

proc dfs(i,j: int): int64=
  if i == j: return A[i]
  if dp[i][j] != inf: return dp[i][j]
  result = max(A[i]-dfs(i+1,j),A[j]-dfs(i,j-1))  
  dp[i][j] = result
echo dfs(0,N-1)

# for i in N:
#   for s in 0..<(N-i):
#     if i==0:
#       dp[s][s] = A[s]
#     else:
#       let e = s+i
#       dp[s][e] = max(A[s]-dp[s+1][e],A[e]-dp[s][e-1])
# echo dp[0][N-1]
