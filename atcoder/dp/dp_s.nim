# #contest_doc
# name Digit_Sum
# url https://atcoder.jp/contests/dp/tasks/dp_s
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

input:
  K: chars
  D: int
dmp (K,D)

useDynamicModInt(mint, -1)
mint.setMod(D)

# dp[i][d] i+1桁で桁和の余りがdとなる通り数
var dp = makeSeq([K.len,D], 0.modint1000000007)
for d in 10: dp[0][d mod D].inc
for i in 1..<K.len:
  for d1 in D:
    for d2 in D:
      dp[i][(d1 + d2) mod D] += dp[i-1][d1] * dp[0][d2]

proc ans(): modint1000000007=
  let N = K.len
  var ctxt = 0.mint
  for i in N:
    let b = K[i]-'0'
    if b == 0: continue
    let digit = N-i
    if digit == 1:
      for j in 0..b:
        if (ctxt-j).val == 0: result.inc
    else:
      for j in b:
        result += dp[digit-2][(ctxt-j).val]
    ctxt -= b
echo ans()-1
