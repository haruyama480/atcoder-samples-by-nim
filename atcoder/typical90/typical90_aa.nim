# #contest_doc
# name Sign_Up_Requests_（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_aa
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  S[N]: string

var registerd = toHashSet[string]([])

for i, s in S:
  if not(registerd.contains(s)):
    echo i+1
  registerd.incl s
