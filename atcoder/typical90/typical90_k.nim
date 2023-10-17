# #contest_doc
# name Gravy_Jobs（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_k
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  N: int
  DCS[N]: (int,int,int); it.sorted(SortOrder.Ascending)

var
  days = 10^5
  dp = newseqwith(days+1,0)

for (d,c,s) in DCS:
  for day in countdown(d,0):
    if day-c>=0:
      dp[day].max=dp[day-c]+s
echo dp.max()
