# #contest_doc
# name Cluttered_Paper（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ab
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/dp/dual_cumulative_sum_2d

input:
  N: int
  point[N]: (int,int,int,int)

const W = 1010
var cs = initDualCumulativeSum2D[int](W, W)
for p in point:
  var (lx,ly,rx,ry) = p
  cs.add(lx..<rx, ly..<ry, 1)
cs.build()

var ans = makeSeq([N], 0)
for i in W:
  for j in W:
    if cs[i,j] > 0:
      ans[cs[i,j]-1] += 1

for a in ans:
  echo a

# var m = makeSeq([1010,1010],0)

# for p in point:
#   var (lx,ly,rx,ry) = p
#   m[lx][ly] += 1
#   m[lx][ry] -= 1
#   m[rx][ly] -= 1
#   m[rx][ry] += 1

# var d = makeSeq([1010,1010],0)
# for i in 1010:
#   for j in 1010:
#     d[i][j] = m[i][j]
#     if j > 0:
#       d[i][j] += d[i][j-1]

# var ans = makeSeq([N], 0)
# for i in 1010:
#   for j in 1010:
#     if i > 0:
#       d[i][j] += d[i-1][j]
#     if d[i][j] > 0:
#       ans[d[i][j]-1] += 1

# for a in ans:
#   echo a
