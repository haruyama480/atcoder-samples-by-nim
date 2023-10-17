# #contest_doc
# name Deck（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bi
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  Q: int
  tx[Q]: (int, int)
 
var
  fore = newSeq[int]()
  back = newSeq[int]()
 
for q in Q:
  case tx[q][0]:
  of 1:
    fore.add tx[q][1]
  of 2:
    back.add tx[q][1]
  else:
    n := tx[q][1]
    if n <= fore.len: echo fore[^n]
    else: echo back[n - fore.len - 1]
 