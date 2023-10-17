# #contest_doc
# name Chimera（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bh
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import harulib/atcoder/extra/dp/longest_increasing_subsequence
import atcoder/extra/other/sliceutils

input:
  N: int
  A: seq[int]
 
dmp A
var (_, foreward) = longestIncreasingSubsequence(A, strict=true, getSeq=true)
var (_, backward) = longestIncreasingSubsequence(A.reversed, strict=true, getSeq=true)
 
backward.reverse()
 
echo zip(foreward, backward).mapIt(it[0]+it[1]).foldl(max(a,b)) - 1
 