# #contest_doc
# name Statue_of_Chokudai（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_r
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils

input:
  T: int
  (L, X, Y): int
  Q: int

for _ in Q:
  input:
    E: int
  let rad = float64(E mod T) / float64(T) * 2 * math.PI
  let zz = (1 - cos(rad)) * L.float64 / 2
  let rr = sqrt(float64(X*X)+pow((Y.float64+L.float64*sin(rad)/2), 2))

  echo radToDeg(arctan(zz/rr))
