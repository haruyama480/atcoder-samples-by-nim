# #contest_doc
# name Max_Manhattan_Distance（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_aj
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,Q): int
  XY[N]: (int, int)
  qq[Q]: int1

PP := makeSeq([N], 0)
QQ := makeSeq([N], 0)

for i in N:
  PP[i] = XY[i][0] + XY[i][1]
  QQ[i] = XY[i][0] - XY[i][1]

SP := PP.sorted
SQ := QQ.sorted

for q in qq:
  echo max([abs(SP[0]-PP[q]),abs(SP[^1]-PP[q]),abs(SQ[0]-QQ[q]),abs(SQ[^1]-QQ[q])])

