# #contest_doc
# name Friendly_Group（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cc
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
  AB[N]: (int1, int1)
K.inc
# dmp AB
 
const DW =  5000
specs := makeSeq([DW,DW],0)
for i in N:
  let (h,w) = AB[i]
  specs[h][w] += 1
# dmpi specs
 
cum := makeSeq([DW,DW],0)
for h in DW:
  for w in DW:
    cum[h][w] = specs[h][w]
    if w > 0:
      cum[h][w] += cum[h][w-1]
    if w >= K:
      cum[h][w] -= specs[h][w-K]
# dmpi cum
 
for w in DW:
  for h in DW:
    specs[h][w] = cum[h][w]
    if h > 0:
      specs[h][w] += specs[h-1][w]
    if h >= K:
      specs[h][w] -= cum[h-K][w]
# dmpi specs
 
echo specs.mapIt(max(it)).max
 