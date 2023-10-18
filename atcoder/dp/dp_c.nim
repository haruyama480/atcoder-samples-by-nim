# #contest_doc
# name Vacation
# url https://atcoder.jp/contests/dp/tasks/dp_c
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  abc[N]: seq[int]

var dp = makeSeq([N,3],0)
for i in N:
  for j in 3:
    if i == 0:
      dp[0][j] = abc[0][j]
    else:
      dp[i][j].max= dp[i-1][(j+1) mod 3] + abc[i][j]
      dp[i][j].max= dp[i-1][(j+2) mod 3] + abc[i][j]
echo dp[^1].max
