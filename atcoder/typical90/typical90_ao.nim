# #contest_doc
# name Piles_in_AtCoder_Farm（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ao
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import harulib/geometry/convex_hull

input:
  N: int
  XY[N]: (int64,int64)

XY=XY.sortedByIt(it[0])
ch := XY.convexHull()

dmp XY
dmp ch[0]
dmp ch[1]

let doubledArea = convexHullHalfArea(ch[0]) - convexHullHalfArea(ch[1])
let outerPoint = ch[0].linePointSize + ch[1].linePointSize - 2
let innerPoint = (doubledArea - outerPoint + 2) div 2

dmp (doubledArea, convexHullHalfArea(ch[0]), convexHullHalfArea(ch[1]))
dmp (outerPoint,innerPoint)

echo outerPoint + innerPoint - XY.len
