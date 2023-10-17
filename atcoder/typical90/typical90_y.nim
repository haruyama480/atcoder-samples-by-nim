# #contest_doc
# name Digit_Product_Equation（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_y
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, sets, hashes, strutils
import sugar
import harulib/utils

input:
  (N,B): int

var ans = toHashSet[int64]([])

proc dfs(s: string, next: int) =

  if s.len == 11:
    # 0を使わない
    var ss = s
    ss.removePrefix('0')
    let p = toSeq(ss.items).mapIt(parseBiggestInt($it)).prod

    if p+B <= N and not ("0" in $(p+B)):
      let target_s = $(p+B)
      var target = toSeq(target_s.items).sorted.join.parseBiggestInt
      if target == s.parseBiggestInt:
        ans.incl(target)
  else:
    for i in next..9:
      dfs(s & $i, i)

dfs("", 0)

dmp (N,B)
dmp ans

var corner = 0
if B <= N and "0" in $B: corner = 1

echo ans.len + corner
