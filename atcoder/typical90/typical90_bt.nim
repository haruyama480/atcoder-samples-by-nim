# #contest_doc
# name Loop_Railway_Plan（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bt
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (H,W): int
  C[H]: chars
 
dmp (H,W)
dmpi C
 
type posi = (int,int)
let moves = @[[0,1],[0,-1],[1,0],[-1,0]]
var went = makeSeq([H,W], false)
var depth = 0
var start = (0, 0)
 
proc recur(now: posi): int=
  result = -1
  depth.inc
  went[now[0]][now[1]] = true
  for move in moves:
    ny := now[0] + move[0]
    nx := now[1] + move[1]
    if ny >= H or ny < 0 or nx >= W or nx < 0 or C[ny][nx] == '#': continue
    if ny == start[0] and nx == start[1]: result.max= depth
    if went[ny][nx]: continue
    result.max= recur((ny,nx))
  went[now[0]][now[1]] = false
  depth.dec
 
var ans = -1
for i in H:
  for j in W:
    if C[i][j] == '.':
      start = (i,j)
      ans.max= recur(start)
if ans == 2:
  ans = -1
echo ans
 