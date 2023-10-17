# #contest_doc
# name Shift_and_Swapping（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ar
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
 
input:
  (N,Q): int
  A: seq[int]
 
shift := 0
for q in Q:
  input:
    (t,x,y): int1
  if t == 0:
    swap(A[(x-shift+N) mod N], A[(y-shift+N) mod N])
  if t == 1:
    shift.inc
  if t == 2:
    echo A[(x-shift+N) mod N]
 