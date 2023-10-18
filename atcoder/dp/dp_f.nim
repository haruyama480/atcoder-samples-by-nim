# #contest_doc
# name LCS
# url https://atcoder.jp/contests/dp/tasks/dp_f
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  s: string
  t: string

var dp = makeSeq([s.len+1,t.len+1],0)

for i in s.len:
  for j in t.len:
    dp[i][j+1].max= dp[i][j]
    dp[i+1][j].max= dp[i][j]
    dp[i+1][j+1].max= dp[i+1][j]
    dp[i+1][j+1].max= dp[i][j+1]
    if s[i] == t[j]:
      dp[i+1][j+1].max= dp[i][j]+1

var 
  (x,y) = (s.len, t.len)
  score = dp[s.len][t.len]
  ans = makeSeq([score], '-')
while score > 0:
  if s[x-1] == t[y-1]:
    score.dec; x.dec; y.dec
    ans[score] = s[x]
  else:
    if dp[x][y] == dp[x-1][y]:
      x.dec
    else:
      y.dec
if ans.len > 0:
  echo ans.join
