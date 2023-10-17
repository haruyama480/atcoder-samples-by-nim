# #contest_doc
# name K_Factors（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ad
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int

var s = makeSeq([N+1], 0)
for i in 2..N:
  if s[i] != 0:
    continue
  for k in countup(i,N,i):
    s[k].inc

echo s.filterIt(it >= K).len
