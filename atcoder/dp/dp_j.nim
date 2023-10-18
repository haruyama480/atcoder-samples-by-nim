# #contest_doc
# name Sushi
# url https://atcoder.jp/contests/dp/tasks/dp_j
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  N: int
  a: seq[int]

var dp = makeSeq([N+1,N+1,N+1],-1.0)
dp[0][0][0] = 0

proc dfs(one,two,three: int): float=
  if dp[one][two][three] != -1.0:
    return dp[one][two][three]
  result = N.float
  if three > 0:
    result += dfs(one, two+1, three-1) * three.float
  if two > 0:
    result += dfs(one+1, two-1, three) * two.float
  if one > 0:
    result += dfs(one-1, two, three) * one.float
  result /= (one + two + three).float
  dp[one][two][three] = result
  dmp (one,two,three,result)

var cnts = makeSeq([4],0)
for i in N: cnts[a[i]].inc
echo dfs(cnts[1],cnts[2],cnts[3])
