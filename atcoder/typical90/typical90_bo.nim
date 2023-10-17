# #contest_doc
# name Base_8_to_9（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bo
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): (string, int)
 
proc fromBase(x: seq[int64], base: int64): int64=
  var ss:int64 = 0
  for i in x.reversed:
    ss += i
    ss *= base
  return ss div 8
 
proc toBase(x: int64, base: int64): seq[int64]=
  var xx = x
  while xx > 0 :
    result.add(xx mod base)
    xx = xx div base
 
if N == "0":
  echo 0
else:
  var acc = N.toSeq.mapIt(parseInt64($it)).reversed
  dmp acc
  proc replace(it: int64): int64=
    if it == 8: int64(5)
    else: it
 
  for _ in int(K):
    acc = acc.fromBase(8).toBase(9).map(replace)
 
  acc.reverse
  echo acc.join