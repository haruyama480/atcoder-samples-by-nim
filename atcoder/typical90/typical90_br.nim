# #contest_doc
# name Plant_Planning（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_br
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  XY[N]: (int64,int64)
 
var X = XY.mapIt(it[0]).sorted
var Y = XY.mapIt(it[1]).sorted
 
proc cost(A: var seq[int64], ind: int64): int64=
  A.mapIt(abs(it - A[ind])).foldl(a+b)
 
var costX = X.cost(N div 2)
if N > 3:
  costX.min= X.cost((N div 2)+1)
 
var costY = Y.cost(N div 2)
if N > 3:
  costY.min= Y.cost((N div 2)+1)
 
echo costX + costY
 