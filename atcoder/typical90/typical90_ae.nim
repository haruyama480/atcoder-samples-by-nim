# #contest_doc
# name VS_AtCoder（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ae
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  W: seq[int]
  B: seq[int]

dp := makeSeq([51, 1326], -1)

proc grundy(w:int, b:int): int =
  if dp[w][b] >= 0:
    return dp[w][b]
  defer:
    dp[w][b] = result

  gs := initHashSet[int]()
  if w >= 1:
    gs.incl grundy(w-1,b+w)
  for k in 1 .. (b div 2):
    gs.incl grundy(w,b-k)
  ret := 0
  while ret in gs: ret.inc()
  ret

if zip(W,B).mapIt(grundy(it[0],it[1])).foldl(a xor b) == 0:
  echo "Second"
else:
  echo "First"
