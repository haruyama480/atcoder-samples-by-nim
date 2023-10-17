# #contest_doc
# name Uplift（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bl
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,Q): int
  A: seq[int]
  LRV[Q]: (int1, int, int)
 
# var delta: seq[int64] = zip(A[0..<N-1], A[1..<N]).mapIt((int64)it[0]-it[1])
# var E: int64 = delta.mapIt(abs(it)).foldl((int64)a+b)
var delta = newSeq[int64](N-1)
var E: int64 = 0
for i in N-1:
  delta[i] = A[i] - A[i+1]
  E += delta[i].abs
 
for q in Q:
  var (l,r,v) = LRV[q]
  dmp (l,r,v)
  if l != 0:
    l.dec
    prev := delta[l].abs
    delta[l] -= v
    next := delta[l].abs
    E += next - prev
  if r != N:
    r.dec
    prev := delta[r].abs
    delta[r] += v
    next := delta[r].abs
    E += next - prev
  echo E
 
