# #contest_doc
# name AtCoder_Ekiden（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_af
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/algorithmutils
import atcoder/extra/graph/graph_template

input:
  N: int
  A[N]: seq[int]
  M: int
  X[M]: (int1,int1)
 
var anti = makeSeq([N,N],1)
for i in M:
  anti[X[i][0]][X[i][1]] = -1
  anti[X[i][1]][X[i][0]] = -1
 
const INF = int.high
var ans = INF
for order in toSeq(iota(N)).permutation:
  score := 0
  success := true
  for i in N:
    score += A[order[i]][i] # 選手 i が区間 i を走る
    if i > 0 and anti[order[i-1]][order[i]] < 0:
      success = false
      break
  if success:
    ans.min= score
 
if ans == INF:
  echo -1
else:
  echo ans
 