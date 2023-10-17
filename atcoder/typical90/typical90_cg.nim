# #contest_doc
# name Multiplication_085（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cg
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import harulib/math/divisor
import atcoder/extra/other/sliceutils

 
input:
  K: int64
 
# # 素因数分解
# proc prime_factorization(x:int64):seq[(int64, int)] =
#   if x == 1: return
#   x := x
#   let maxp = (x+1).float64.sqrt.int64
#   for p in 2..maxp:
#     cnt := 0
#     while x mod p == 0:
#       x.div= p
#       cnt.inc
#     if cnt > 0:
#       result.add((p, cnt))
#   if x != 1:
#     result.add((x, 1))
 
# 約数羅列
# proc divisor(x: int64):seq[int64]=
#   for d in 1..x:
#     if d*d > x: break
#     if x mod d == 0:
#       result.add d
#       if d*d != x:
#         result.add x div d
 
var ans = int64(0)
let ds = divisor(K).reversed
dmp (K,ds)
for i in ds.len:
  for j in i..<ds.len:
    if (K div ds[i]) mod ds[j] != 0: continue
    let c = (K div ds[i]) div ds[j]
    if c <= ds[j]:
      ans.inc
 
echo ans