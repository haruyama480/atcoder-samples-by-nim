# #contest_doc
# name Typical_Shop（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ay
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/algorithmutils


input:
  (N,K,P): int
  A: seq[int64]
 
N1 := N div 2
N2 := N - N1
 
# [offset,offset+n)のうちk個選べる場合に、取りうる合計価格
proc prices(offset, n, k:int): seq[int64] =
  if k == 0: return
  for comb in toSeq(offset..<(offset+n)).combination(k):
    summ := comb.mapIt((int64)A[it]).foldl(a+b)
    result.add summ
 
dmp (N,K,P)
dmp A
dmp (N1, N2)
 
var ans:int64 = 0
for K1 in 0..K:
  K2 := K - K1
  if K1 > N1 or K2 > N2: continue
  p1 := prices(0, N1, K1).sorted
  p2 := prices(N1, N2 ,K2).sorted
  if K2 == 0:
    ans += p1.upperBound(P)
    continue
  if K1 == 0:
    ans += p2.upperBound(P)
    continue
 
  # i番目までとったときに、p2の何番目までなら合計P以下になるか
  j := p2.len - 1
  for i in p1.len:
    while j >= 0 and P < p1[i] + p2[j]:
      j.dec
    if j < 0: break
    ans += j + 1
 
echo ans
 