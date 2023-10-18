# #contest_doc
# name Colorful_Graph（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ce
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

import atcoder/extra/graph/graph_template
import atcoder/extra/tree/doubling_lowest_common_ancestor

input:
  (N,M): int
  AB[M]: (int1,int1)
  Q: int

var g = initGraph(N)
for i in M:
  g.addBiEdge(AB[i][0], AB[i][1])

var 
  color = makeSeq([N],1)
  time = makeSeq([N],-1)
  isHub = makeSeq([N],false)
  hcolor = makeSeq([N],1) # hub が直接塗られた
  htime = makeSeq([N],-1)


for i in N:
  if g.adj[i].len > (2*M).float.sqrt.int:
    isHub[i] = true

var h = initGraph(N)
for i in N:
  if isHub[i]:
    for e in g.adj[i]:
      if isHub[e.dst]: 
        h.addBiEdge(i,e.dst)

for t in Q:
  input:
    (x,y): (int1, int)
  dmp (x,y)

  var
    mtime = -1
    c = 1
  
  # output
  if mtime < time[x]:
    c = color[x]; mtime = time[x]
  if isHub[x]:
    for e in h.adj[x]:
      if mtime < htime[e.dst]:
        c = hcolor[e.dst]; mtime = htime[e.dst]
  else:
    for e in g.adj[x]:
      if isHub[e.dst] and mtime < htime[e.dst]:
        c = hcolor[e.dst]; mtime = htime[e.dst]
  echo c
  dmp c

  # update
  color[x] = y; time[x] = t
  if isHub[x]:
    hcolor[x] = y; htime[x] = t
  else:
    for e in g.adj[x]:
      color[e.dst] = y; time[e.dst] = t
    
  dmp color
