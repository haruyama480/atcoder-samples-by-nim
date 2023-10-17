# #contest_doc
# name Select_+／-_One（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_x
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  (_,K): int
  A: seq[int]
  B: seq[int]

let d = zip(A,B).mapIt(abs(it[1]-it[0])).sum

if K >= d and (K-d) mod 2 == 0:
  echo "Yes"
else:
  echo "No"
