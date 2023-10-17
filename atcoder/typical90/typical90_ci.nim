# #contest_doc
# name Chokudai's_Demand（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ci
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/binary_search
import atcoder/extra/graph/warshall_floyd

input:
  (N,P,K): int
  A[N]: seq[int]
 
dmp (N,P,K)
 
# Xスヌーク設定時のPスヌーク以下の組み合わせの数
proc pathnum(X: int): int =
  var B = A
  for i in N:
    for j in N:
      if A[i][j] < 0:
        B[i][j] = X
  let ret = B.warshallFloyd()
  for i in N-1:
    for j in (i+1)..<N:
      if ret[i][j] <= P: result.inc
 
const MAX = 10^9 + 10
let minn = minLeft(x => pathnum(x) <= K, 1..MAX) # f を満たす最小の x
let maxx = minLeft(x => pathnum(x) < K, 1..MAX)
dmp (minn, maxx)
 
if maxx == minn:
  echo 0
else:
  if maxx > MAX:
    echo "Infinity"
  else:
    echo maxx - minn
 
 
# binary searchについてのコメント
  # fを満たす最小のrを返す。(rは満たし、lは満たさないを維持して2分探索。どれも満たさない場合はr+1)
  # proc minLeft*(f:proc(x:int):bool, s:Slice[int]):int =
  #   var (l, r) = (s.a - 1, s.b)
  #   if not f(r): return s.b + 1
  #   while r - l > 1:
  #     let d = (r - l) shr 1
  #     let m = l + d
  #     if f(m): r = m
  #     else: l = m
  #   return r
 
  # fを満たす最大のlを返す。(lは満たし、rは満たさないを維持して2分探索。どれも満たさない場合はl-1)
  # proc maxRight*(f:proc(x:int):bool, s:Slice[int]):int =
  #   var (l, r) = (s.a, s.b + 1)
  #   if not f(l): return s.a - 1
  #   while r - l > 1:
  #     let d = (r - l) shr 1
  #     let m = l + d
  #     if f(m): l = m
  #     else: r = m
  #   return l