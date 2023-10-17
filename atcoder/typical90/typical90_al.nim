# #contest_doc
# name Large_LCM（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_al
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (A,B): int64
 
dmp (A,B)
 
func digits(x: int64): int64 =
  xx := x
  while xx > 0:
    result.inc
    xx = xx div 2
 
if digits(A div gcd(A, B)) + digits(B) - 2 >= 61:
  echo "Large"
else:
  ans := lcm(A,B)
  if ans > 10^18:
    echo "Large"
  else:
    echo ans
 