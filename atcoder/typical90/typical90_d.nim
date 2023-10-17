# #contest_doc
# name Cross_Sum（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_d
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils

input:
  (H, W): (int, int)
  A[H]: seq[int]

# let row = A.map(x => x.foldl(a+b))
# let col = A.transpose().map(x => x.foldl(a+b))
# 上で書いてもいいが、transposeのコピーが減るため下のが速い
var row = Seq[H: 0]
var col = Seq[W: 0]
for i in H:
  for j in W:
    row[i] += A[i][j]
    col[j] += A[i][j]

var B = Seq[H, W:int]
for i in H:
  for j in W:
    B[i][j] = row[i] + col[j] - A[i][j]
for i in H:
  echo B[i].join(" ")
