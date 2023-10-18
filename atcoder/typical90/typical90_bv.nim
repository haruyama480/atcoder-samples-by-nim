# #contest_doc
# name ABC_String_2（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bv
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  S: chars; it.mapIt(it - 'a')

# a..ab を全部aにするscore[i] = それまでのscoreの和+1
score := makeSeq([N], 1.int64)
acc := 1.int64
for i in 1..<N:
  score[i] = acc + 1
  acc += score[i]

echo zip(S,score).mapIt(it[0]*it[1]).sum
