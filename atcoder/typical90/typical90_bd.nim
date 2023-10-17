# #contest_doc
# name Lucky_Bag（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bd
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,S): int
  AB[N]: (int,int)
 
MAXD := 10^5+10
dp := makeSeq([N+1, MAXD], false)
 
dp[0][0] = true
for i in 1..N:
  for j in MAXD:
    if j+AB[i-1][0] < MAXD and dp[i-1][j]: dp[i][j+AB[i-1][0]] = true
    if j+AB[i-1][1] < MAXD and dp[i-1][j]: dp[i][j+AB[i-1][1]] = true
 
if not dp[N][S]:
  echo "Impossible"
else:
  ans := newSeqWith(0, "")
  j := S
  for i in countdown(N-1,0):
    if j - AB[i][0] >= 0 and dp[i][j - AB[i][0]]:
      ans.add "A"
      j -= AB[i][0]
      continue
    if j - AB[i][1] >= 0 and dp[i][j - AB[i][1]]:
      ans.add "B"
      j -= AB[i][1]
      continue
    assert false
  echo ans.reversed.join
 