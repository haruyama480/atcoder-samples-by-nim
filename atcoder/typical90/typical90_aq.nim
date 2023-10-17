# #contest_doc
# name Maze_Challenge_with_Lack_of_Sleep（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_aq
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (H,W): int
  (sx,sy): int1
  (tx,ty): int1
  S[H]: chars
 
cost := makeSeq([H,W],-1)
togov := makeSeq([H,W],false)
togoh := makeSeq([H,W],false)
queue := initdeque[(int,int,int)]()
 
queue.addLast((sx,sy, 0))
togov[sx][sy] = true
togoh[sx][sy] = true
 
while queue.len > 0:
  var (x,y,c) = queue.popFirst()
  if cost[x][y] >= 0: continue
  cost[x][y] = c
 
  proc nextv(nx,ny: int): bool =
    if nx >= H or nx < 0 or ny >= W or ny < 0 or S[nx][ny] == '#' or togov[nx][ny]: return true
    queue.addLast((nx,ny,c+1))
    togov[nx][ny] = true
    return false
  proc nexth(nx,ny: int): bool =
    if nx >= H or nx < 0 or ny >= W or ny < 0 or S[nx][ny] == '#' or togoh[nx][ny]: return true
    queue.addLast((nx,ny,c+1))
    togoh[nx][ny] = true
    return false
 
  for i in 1..10^4:
    if nextv(x+i, y): break
  for i in 1..10^4:
    if nextv(x-i, y): break
  for i in 1..10^4:
    if nexth(x, y+i): break
  for i in 1..10^4:
    if nexth(x, y-i): break
 
echo cost[tx][ty] - 1
 