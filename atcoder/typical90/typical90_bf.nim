# #contest_doc
# name Original_Calculator（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bf
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
 
proc nextN(x: int): int =
  var xx = x
  for i in countdown(4,0):
    result += xx div 10^i
    xx = xx mod 10^i
  result = (result + x) mod 10^5
 
# dmp nextN(11111) == 11116
# dmp nextN(99999) == 44
# dmp nextN(12345) == 12360
 
proc Cycle(n: int): (int,int,seq[int]) = # offset, cyclelen
  olds := initHashSet[int]()
  nexts := newSeqWith(0, 0)
 
  var now = N
  nexts.add now
  while true:
    now = nextN(now)
    if olds.contains now:
      for i in nexts.len:
        if nexts[i] == now:
          return (i, nexts.len-i, nexts)
    else:
      olds.incl now
      nexts.add now
 
let (offset, cyclelen, nexts) = Cycle(N)
if K <= offset:
  echo nexts[K]
else:
  K -= offset
  echo nexts[offset + (K mod cyclelen)]
 