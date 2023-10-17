# #contest_doc
# name Multiple_of_9（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ap
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

type mint = modint1000000007
 
input:
  K: int
 
dp := makeSeq([K+1,9],(mint)0) # 和をiまで使い、桁の和がjの通り数
 
dp[0][0] = 1
for k in 1..K:
  for i in 1..9:
    # 新しい桁にiを採用する
    for j in 9:
      if k - i >= 0:
        dp[k][(i+j) mod 9] += dp[k-i][j]
 
echo dp[K][0]
 