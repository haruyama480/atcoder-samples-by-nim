# #contest_doc
# name CP_Classes（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_g
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/inf

input:
  N: int
  A: seq[int]; it.sorted
  Q: int
  B[Q]: int
 
for bb in B:
  var i = A.lower_bound(bb)
  var ans = int.high
  if i < N: ans.min=abs(bb - A[i])
  if i > 0: ans.min=abs(bb - A[i - 1])
  echo ans
 