# #contest_doc
# name Select_5（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bc
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/algorithmutils
import harulib/modint

input:
  (N,P,Q): int
  A: seq[int64]

ans := 0
# TLE
# for comb in toSeq(N).combination(5):
#   if comb.mapIt((int64)A[it]).foldl(a*b mod P) == Q:
#     ans.inc

type Dymint* = concept x, type T
  x.v
proc `*`*(a:Dymint,b:Dymint):auto = 
  let x = ((a.v mod P) * (b.v mod P)) mod P
  result = Dymint(x)

for i in 0..N-5:
  for j in i+1..N-4:
    for k in j+1..N-3:
      for l in k+1..N-2:
        for m in l+1..N-1:
          var p = Dymint(A[i]) * Dymint(A[j]) * Dymint(A[k]) * Dymint(A[l]) * Dymint(A[m])
          if p.v == Q: ans.inc
echo ans
