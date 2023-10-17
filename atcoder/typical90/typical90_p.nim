# #contest_doc
# name Minimum_Coins（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_p
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  N: int
  (A,B,C): int

var ans = int.inf
for a in 0..9999:
  for b in 0..(9999-a):
    let s = N - a * A - b * B
    if s >= 0 and s mod C == 0:
      let c = s div C
      ans.min=a + b + c
echo ans
