# #contest_doc
# name Various_Arrays（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bn
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  LR[N]: (int, int)
 
# (p,q) ∈ N に対して、転倒する期待値を計算する
# 適当に計算しても O(100*100)
proc pairAns(p, q: int):float =
  sum := 0
  cnt := 0
  defer: result = (float)cnt/sum
  for i in LR[p][0]..LR[p][1]:
    for j in LR[q][0]..LR[q][1]:
      sum.inc
      if i > j: cnt.inc
 
proc ans(): float =
  for i in 0..<N-1:
    for j in i+1..<N:
      result += pairAns(i,j)
 
echo ans()
 