# #contest_doc
# name Crossing_Segments（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_q
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/segtree
import sugar

input:
  (N,M): int
  LR[M]: (int1, int1)

if N < 20:
  dmp (N,M)
  dmp LR

var ans = (int64(M) * int64(M-1)) div 2

lcnt := newSeq[int](N) # l or r = iの数
for m in M:
  lcnt[LR[m][0]].inc
  lcnt[LR[m][1]].inc

# L_i == R_j または R_i == L_j な組み合わせを引く
block:
  tmp := 0
  for i in N:
    tmp += (lcnt[i] * (lcnt[i] - 1)) div 2
  dmp tmp
  ans -= tmp

let S = (x:int64,y:int64) => x+y
let E = () => int64(0)

var rst = initSegTree(makeSeq([N],int64(0)), S, E)
LLR := LR.sortedByIt((it[0], it[1])) # Lでsort
dmp LLR
block:
  tmp := int64(0)
  for m in M:
    w := M - m - 1
    if LLR[w][1] - LLR[w][0] > 2:
      tmp += rst.prod((LLR[w][0]+1)..(LLR[w][1]-1))
    v := rst.get(LLR[w][1]); rst.set(LLR[w][1], v+1) # inc
  dmp tmp
  ans -= tmp

block:
  tmp := int64(0)
  for m in M:
    if LLR[m][0]-1 > 0:
      tmp += rst.prod(0..(LLR[m][0]-1))
  dmp tmp
  ans -= tmp

dmp ans
echo ans
