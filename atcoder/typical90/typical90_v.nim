# #contest_doc
# name Cubic_Cake（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_v
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  (a,b,c): int

let g = a.gcd(b).gcd(c)

echo a div g + b div g + c div g - 3
