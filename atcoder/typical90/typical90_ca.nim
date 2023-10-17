# #contest_doc
# name Two_by_Two（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ca
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (H,W): int
  A[H]: seq[int]
  B[H]: seq[int]
 
dmpi A
dmpi B
 
proc tuneA(y,x:int): int=
  let delta = A[y][x] - B[y][x]
  result = delta
  A[y][x] -= delta
  A[y+1][x] -= delta
  A[y][x+1] -= delta
  A[y+1][x+1] -= delta
 
proc tune(): int=
  for i in H-1:
    for j in W-1:
      result += abs(tuneA(i,j))
  for i in H:
    if A[i][W-1] != B[i][W-1]:
      return -1
  for j in W:
    if A[H-1][j] != B[H-1][j]:
      return -1
 
let ans = tune()
if ans >= 0:
  echo "Yes"
  echo ans
else:
  echo "No"
 