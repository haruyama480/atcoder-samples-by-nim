# #contest_doc
# name Let's_Share_Bit（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cb
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,D): int64
  A: seq[int64]

var ans:int64 = 0
for b in 2^N:
  par := 1
  let fullbit: int64 = 2^D - 1
  buf := fullbit
  # A_iの組み合わせに対して論理積が0となる通り数を、包除原理で除算していく
  # 結果としてどのA_iに対しても論理積が0でない通り数が残る
  for i in N:
    if b.bitand(2^i) > 0:
      par *= -1
      buf = buf.bitand(fullbit - A[i])
  ans += par * 2^(buf.countSetBits)

echo ans
