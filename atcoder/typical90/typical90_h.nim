# #contest_doc
# name AtCounter（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_h
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/modint
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils

type mint = modint1000000007

input:
  N: int
  S: string

let T = "atcoder"
var dp = Seq[N: mint(0)]
for j in N:
  if S[j] == T[0]:
    dp[j] = 1
for i in 1 ..< T.len:
  var
    s = mint(0)
    dp2 = Seq[N: mint(0)]
  for j in N:
    if T[i] == S[j]:
      dp2[j] = s
    s += dp[j]
  swap dp, dp2
echo dp.sum
