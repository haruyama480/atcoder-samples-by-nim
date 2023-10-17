# #contest_doc
# name Restricted_Digits（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_e
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/seq_array_utils
import atcoder/extra/other/assignment_operator
import atcoder/modint
type mint = modint1000000007

input:
  (N,B,K): int
  C: seq[int]

dmp (N,B,K)
dmp C

var A = Seq[B:mint(0)] # 1桁使ってあまりがiとなる組み合わせの数
for c in C:
  A[c mod B] += 1

# 長さBの配列のmod付き掛け算
proc prod(a, b:seq[mint]):auto =
  result = Seq[B:mint(0)]
  for i, aa in a:
    for j, bb in b:
      let k = (i + j) mod B
      result[k] += aa * bb

# Aをr倍する
proc rotate(a:seq[mint], r:int):seq[mint] =
  result = Seq[B:mint(0)]
  for i,t in a:
    result[i*r mod B] += t

proc poww(a:seq[mint], n:int):seq[mint] =
  result = @[mint(1)] & Seq[B-1:mint(0)]
  var aa = a
  var n = n
  var r = 10
  while n > 0:
    if n % 2 != 0: # 最小2乗法
      result = prod(aa, rotate(result, r))
    aa = prod(aa, rotate(aa, r))
    n.div= 2
    r = r * r mod B

echo(poww(A, N)[0])

