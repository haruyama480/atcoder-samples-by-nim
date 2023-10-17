# #contest_doc
# name There_are_few_types_of_elements（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ah
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K): int
  A: seq[int]

dmp (N,K)
dmp A

ans := 0

var
  scan_s: int = 0
  scan_e: int = 0
table := initTable[int,int]()
while scan_s < N:
  while scan_e < N:
    discard table.hasKeyOrPut(A[scan_e], 0)
    if table.len > K:
      table.del(A[scan_e])
      break
    table[A[scan_e]].inc
    scan_e += 1
    dmp ("a", table)

  ans.max= scan_e - scan_s

  if table[A[scan_s]] == 1:
    table.del(A[scan_s])
  else:
    table[A[scan_s]].dec
  scan_s += 1
  dmp ("b", table)

echo ans
