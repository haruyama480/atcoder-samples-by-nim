# #contest_doc
# name Three_Point_Angle（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_i
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils

input:
  N: int
  AB[N]: (int, int)
dmp N
dmp AB

type P = (int, int)

proc angle(axis, x:P): float64 =
  return radToDeg(arctan2(float64(x[0]-axis[0]), float64(x[1]-axis[1])))

var delta = 0.0
for axis in N:
  var angles = Seq[0: (0,0.0)] # N-1
  for i, ab in AB:
    if i != axis:
      angles.add (i, angle(AB[axis],ab))
  angles = angles.sortedByIt(it[1])

  var angs = angles.mapIt(it[1])
  for a in angs:
    var target = a + 180.0
    if target > 360: target -= 360.0
    let min_i = angs.lowerBound(target)
    if min_i == 0 or min_i == N-1:
      delta.max= min(abs(angs[0] - a), 360-abs(angs[0] - a))
      delta.max= min(abs(angs[N-2] - a), 360-abs(angs[N-2] - a))
    else:
      delta.max= min(abs(angs[min_i] - a), 360-abs(angs[min_i] - a))
      delta.max= min(abs(angs[min_i-1] - a), 360-abs(angs[min_i-1] - a))

echo delta
