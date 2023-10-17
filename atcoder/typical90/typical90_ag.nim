# #contest_doc
# name Not_Too_Bright（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ag
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,W): int

if N == 1 or W == 1:
  echo N*W
else:
  echo ((N+1) div 2) * ((W+1) div 2)
