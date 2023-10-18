# #contest_doc
# name Partitions_and_Inversions（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ck
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/segtree
import atcoder/modint
 
type mint = modint1000000007

input:
  (N,K): (int, int64)
  A: seq[int]
dmp K

block: # 座標圧縮
  let aa = A.sorted.deduplicate(isSorted=true)
  var toId = initTable[int,int]()
  for i in aa.len: toId[aa[i]] = i
  for i in N: A[i] = toId[A[i]]
dmp A

let 
  S = (x:int,y:int) => x+y
  E = () => int(0)
var cnts = initSegTree(makeSeq([N],0), S, E)

# 区間[l,r]の転倒数を考えたとき、rに対してKを超える最大のl
var
  cls = makeSeq([N],0)
  l = N-1
  k = 0
cnts.set(A[l],cnts.get(A[l])+1)
for r in countdown(N-1,0):
  dmp (l,r,k)
  while k <= K and l >= 0:
    l.dec
    if l < 0: break
    cnts.set(A[l],cnts.get(A[l])+1)
    k += cnts.prod(0..<A[l])
    dmp (l,r,k)
  cls[r] = l
  cnts.set(A[r],cnts.get(A[r])-1)
  k -= cnts.prod((A[r]+1)..<N)
dmp cls

var
  dp = makeSeq([N+1],0.mint)
  dp2 = makeSeq([N+1],0.mint) # dp[i]までの和
for i in 0..N:
  if i <= 0:
    dp[i] = 1
    dp2[i] = 1
  else:
    # i個までの要素の分割数(1-index)
    # (cl[i-1],i],..,[i,i] という分割ができる
    # 通り数的には、dp[cl[i-1]-1],..,dp[i-1]の和
    if cls[i-1] >= 0:
      dp[i] = dp2[i-1] - dp2[cls[i-1]]
    else:
      dp[i] = dp2[i-1]
    dp2[i] = dp2[i-1] + dp[i]
dmp dp
dmp dp2
echo dp[N]
