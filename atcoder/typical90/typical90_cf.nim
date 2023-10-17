# #contest_doc
# name There_are_two_types_of_characters（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cf
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int64
  S: chars
 
# nC2 を使う
 
ans := (N * (N-1)) div 2
 
var lasting = 1
for i in 1..<N:
  if S[i]==S[i-1]:
    lasting.inc
  else:
    ans -= (lasting * (lasting-1)) div 2
    lasting = 1
ans -= (lasting * (lasting-1)) div 2
 
echo ans
 