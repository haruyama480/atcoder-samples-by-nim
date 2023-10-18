# #contest_doc
# name Grid_1
# url https://atcoder.jp/contests/dp/tasks/dp_h
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint
type mint = modint1000000007

input:
  (H,W): int
  a[H]: chars

var
  dp = makeSeq([H,W],0.mint)
  queue = initDeque[(int,int)]()
  visited = makeSeq([H,W],false)

dp[0][0] = 1
queue.addLast (0,0)

const dh = @[0,1]
const dw = @[1,0]
while queue.len > 0:
  let (h,w) = queue.popFirst
  if visited[h][w]: continue
  visited[h][w] = true
  for i in dh.len:
    let nh = h+dh[i]
    let nw = w+dw[i]
    if not (nh in 0..<H) or not (nw in 0..<W): continue
    if visited[nh][nw] or a[nh][nw] == '#': continue
    dp[nh][nw] += dp[h][w]
    queue.addLast (nh,nw)
echo dp[^1][^1]