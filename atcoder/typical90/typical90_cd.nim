# #contest_doc
# name Counting_Numbers（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cd
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

type mint = modint1000000007
 
input:
  (L,R): int64
 
proc digits(x: int64): int =
  x := x
  while x > 0 :
    result.inc
    x.div= 10
 
# 個数のみ
proc acum(l,r:int64): mint =
  result += l+r
  result *= r-l+1
  result /= 2
 
 
proc ans(): mint =
  if digits(L)==digits(R):
    return acum(L,R)*digits(L)
  else:
    for d in digits(L)..digits(R):
      if d == digits(L):
        result += acum(L, 10^d-1) * d
      else:
        if d == digits(R):
          result += acum(10^(d-1), R) * d
        else:
          result += acum(10^(d-1), 10^d-1) * d
 
echo ans()
 