# #contest_doc
# name Encyclopedia_of_Parentheses（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_b
# version 0.0.1

{. warning[UnusedImport]:off .}
import atcoder/extra/other/bitutils
import atcoder/extra/other/sliceutils
import sequtils, math, algorithm, strformat, strutils, bitops, deques, heapqueue, bitops
import harulib/utils

input:
  N: Natural

if N mod 2 == 1:
  quit()
var v: seq[string] = @[]
for b in 2^N:
  var s = 0
  var valid = true
  var ans = ""
  for i in N:
    if b[i] != 0:
      s.inc; ans &= "("
    else: s.dec; ans &= ")"
    if s < 0: valid = false;break
  if s != 0: valid = false
  if not valid: continue
  v.add ans
v.sort

echo v.join("\n")
