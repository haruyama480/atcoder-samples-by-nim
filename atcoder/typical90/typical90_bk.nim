# #contest_doc
# name Monochromatic_Subgrid（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bk
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/algorithmutils

input:
  (H,W): int
  P[H]: seq[int1]
 
# すべてのi∈SにおいてP[i][j]の値がjについて同じで、その総数が最も多いものの、総数を返す
# 例. given:[[11,22,33,22],[11,22,22,33,22]], return: 2.
proc sameSize(S: seq[int]): int = 
  var cnt = makeSeq([H*W], 0)
  defer: result = cnt.max
  for i in W:
    first := -1
    for s in S:
      if first == -1: first = P[s][i]
      else:
        if first != P[s][i]:
          first = -1
          break
    if first >= 0:
      cnt[first].inc
      discard
 
dmp (H,W)
dmp P
# dmp sameSize(@[0,1])
 
var ans = 0
for seed in 2^H:
  if seed == 0: continue
  ss := bitvals(seed, H)
  ans.max= sameSize(ss) * ss.len
echo ans
 