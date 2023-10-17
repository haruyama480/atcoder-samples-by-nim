# #contest_doc
# name We_Used_to_Sing_a_Song_Together（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_n
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  _: int
  A: seq[int]; it.sorted
  B: seq[int]; it.sorted

echo zip(A,B).mapIt(abs(it[0]-it[1])).foldl(a+b)
