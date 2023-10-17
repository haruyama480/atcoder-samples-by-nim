# #contest_doc
# name Smallest_Subsequence（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_f
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils
import atcoder/extra/other/assignment_operator

input:
  (N,K): int
  S: string

const C = 26

var dp = Seq[N+1: Seq[C:0]]

for j in C:
  dp[N][j] = -1

for i in countdown(N-1, 0):
  for j in C:
    if S[i] - 'a' == j:
      dp[i][j] = i
    else:
      dp[i][j] = dp[i+1][j]

dmp (N,K)
dmp S
dmpi dp

var i = 0
var kk = 0
var ans = Seq[0:""]
while kk != K and i < N:
  for j in C:
    if dp[i][j] >= 0 and (N - dp[i][j] - 1) >= (K - kk - 1):
      # select
      ans.add $('a'+j)
      kk.inc
      i = dp[i][j] + 1
      break

echo ans.join()
