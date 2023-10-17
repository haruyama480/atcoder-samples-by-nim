# #contest_doc
# name Yokan_Party（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_a
# version 0.0.1

import atcoder/extra/other/binary_search
import sequtils, strutils
import harulib/utils

input:
  (_,L): int
  K: int
  A: seq[int]

A.add L
dmp K

proc f(l:int):bool =
  var prev = 0
  var ct = 0
  for i in 0..<A.len:
    if A[i] - prev >= l:
      ct.inc
      prev = A[i]
      if ct == K + 1: return true
  return false
echo f.maxRight(1..L)
