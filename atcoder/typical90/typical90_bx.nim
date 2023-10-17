# #contest_doc
# name Cake_Cut（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bx
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  A: seq[int64]
 
var borders = initHashSet[int64]()
var b: int64= 0
borders.incl b
for i in N:
  b += A[i]
  borders.incl b
let sum = b
 
proc ans()=
  if sum mod 10 != 0:
    echo "No"
  else:
    let d = sum div 10
    b = 0
    if borders.contains ((b + d) mod sum):
      echo "Yes"
      return
    for i in N:
      b += A[i]
      if borders.contains ((b + d) mod sum):
        echo "Yes"
        return
    echo "No"
ans()