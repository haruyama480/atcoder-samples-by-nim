# #contest_doc
# name Permutation
# url https://atcoder.jp/contests/dp/tasks/dp_t
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/dp/cumulative_sum

import atcoder/modint
type mint = modint1000000007

input:
  N: int
  S: chars

# dp[i][j][S]: i桁まで進みSの数字を使いjで終わったときの通り数 → 間に合わない
# dp[i][j]: i桁まで進みi番目の数より大きい数字がj個残っている通り数
var dp = makeSeq([N,N],0.mint)
dp[0].fill(1)
for i in 1..<N:
  var cum = initCumulativeSum[mint](dp[i-1])
  for j in N-i:
    if S[i-1]=='<':
      dp[i][j] = cum[(j+1)..N-i]
    else:
      dp[i][j] = cum[0..j]
echo dp[^1][0]