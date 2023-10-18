# #contest_doc
# name Flowers
# url https://atcoder.jp/contests/dp/tasks/dp_q
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/segtree

input:
  N: int
  H: seq[int1]
  A: seq[int64]

let S = (x:int,y:int) => max(x,y)
let E = () => int(0)
var dp = initSegTree(makeSeq([N],0), S, E) # 高さiで終わる最大の美しさ

for i in N:
  dp.set(H[i], dp.prod(0..<H[i])+A[i])
echo dp.prod(0..<N)
