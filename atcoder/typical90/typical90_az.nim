# #contest_doc
# name Dice_Product（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_az
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

type mint = modint1000000007
 
input:
  N: int
  A[N]: seq[int]
 
echo A.mapIt(it.foldl(a+b)).mapIt(mint(it)).foldl(a*b)
 