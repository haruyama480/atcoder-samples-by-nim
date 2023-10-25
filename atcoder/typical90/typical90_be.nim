# #contest_doc
# name Flip_Flap（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_be
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/math/matrix
import atcoder/modint

useDynamicModInt(mint, -1); mint.setMod 998244353
useDynamicModInt(boolean, -2); boolean.setMod 2

input:
  (N,M):int

A := makeSeq([N, M], 0)
for i in N:
  input:
    T: int
    a: seq[int1]
  for t in T:
    A[i][a[t]] = 1
input:
  S: seq[int]

let
  d1 = DynamicMatrixType(boolean).init(A&S).gaussianElimination[1].len
  d2 = DynamicMatrixType(boolean).init(A).gaussianElimination[1].len

if d1 == d2:
  echo mint(2)^(N-d2)
else:
  echo 0
