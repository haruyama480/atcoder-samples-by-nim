# #contest_doc
# name Red_Painting（★4）
# url https://atcoder.jp/contests/typical90/tasks/typical90_l
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/dsu
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils

input:
  (H, W): int
  Q: int

const NN = 2020

var map = Seq[H+2: Seq[W+2: 0]]

var uf = initDSU((H+2)*(W+2))

proc point(x,y:int): int = x*(W+2) + y

for q in Q:
  input:
    query: seq[int]

  if query[0] == 1:
    let x = query[1]
    let y = query[2]
    map[x][y] = 1

    let dx = @[0,1,0,-1]
    let dy = @[-1,0,1,0]
    for i in 4:
      if map[x+dx[i]][y+dy[i]] == 1:
        uf.merge(point(x,y), point(x+dx[i],y+dy[i]))

    dmp q
    dmpi map
  else:
    let ans = if (map[query[1]][query[2]] == 1) and uf.same(point(query[1],query[2]), point(query[3],query[4])):
        "Yes"
      else:
        "No"
    dmp (query, ans)
    echo ans

