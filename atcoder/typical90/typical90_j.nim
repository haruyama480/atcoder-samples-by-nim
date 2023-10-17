# #contest_doc
# name Score_Sum_Queries（★2）
# url https://atcoder.jp/contests/typical90/tasks/typical90_j
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/dp/cumulative_sum

input:
  N: int
  CP[N]: (int, int)
  Q: int
  LR[Q]: (int1, int1)

let C = CP.mapIt(it[0])
let P = CP.mapIt(it[1])
let L = LR.mapIt(it[0])
let R = LR.mapIt(it[1])

var cs1, cs2 = initCumulativeSum(N, int)
for i in 0..<N:
  if C[i] == 1:
    cs1[i] = P[i]
  else:
    cs2[i] = P[i]
dmp cs1
dmp cs2
for i in 0..<Q:
  echo cs1[L[i]..R[i]], " ", cs2[L[i]..R[i]]
