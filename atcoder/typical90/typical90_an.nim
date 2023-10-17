# #contest_doc
# name Get_More_Money（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_an
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/maxflow

input:
  (N,W): int
  A: seq[int]
  KC[N]: seq[int]

S := N
T := N+1
mfg := initMFGraph[int](N + 2)

for i in N:
  mfg.addEdge(S, i, A[i])
  mfg.addEdge(i, T, W)
  for j in 1..KC[i][0]:
    mfg.addEdge(KC[i][j] - 1, i, int.high)

echo sum(A) - mfg.flow(S, T)
