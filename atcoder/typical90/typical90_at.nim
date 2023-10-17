# #contest_doc
# name I_Love_46（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_at
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  A: seq[int]
  B: seq[int]
  C: seq[int]
 
MOD := 46
MA := makeSeq([MOD], 0)
for i in N: MA[A[i] mod MOD].inc
MB := makeSeq([MOD], 0)
for i in N: MB[B[i] mod MOD].inc
MC := makeSeq([MOD], 0)
for i in N: MC[C[i] mod MOD].inc
 
ans := 0
for i in MOD:
  for j in MOD:
    for k in MOD:
      if (i+j+k) mod MOD == 0:
        ans += MA[i] * MB[j] * MC[k]
echo ans
 