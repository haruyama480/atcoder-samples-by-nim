# #contest_doc
# name Snuke's_Favorite_Arrays（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ch
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/modint
import atcoder/extra/other/sliceutils

type mint = modint1000000007
 
input:
  (N,Q): int
  xyzw[Q]: (int1,int1,int1,int64)
dmp (N,Q)
dmpi xyzw
 
proc ok(bit: int, cases: int): bool=
  for q in Q:
    let (x,y,z,w) = xyzw[q]
    if ((cases.testBit(x)) or (cases.testBit(y)) or (cases.testBit(z))) != w.testBit(bit):
      return false
  return true
 
proc sub(bit: int): mint=
  result = 0
  for i in 2^N:
    if ok(bit, i): result.inc
 
echo toSeq(0..<60).mapIt(sub(it)).foldl(a*b)
 