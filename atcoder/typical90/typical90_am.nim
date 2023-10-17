# #contest_doc
# name Tree_Distance（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_am
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/tree_diameter

input:
  N: int
  AB[N-1]: (int1, int1)
 
var g = initGraph(N)
for i in N - 1: g.addBiEdge(AB[i][0], AB[i][1])
 
chils := makeSeq([N],0)
 
block:
  went := makeSeq([N],false)
  proc dfs(par:int): int =
    defer: return result
    went[par] = true
    for e in g.adj[par]:
      nx := e.dst
      if went[nx]: continue
      result.inc
      result += dfs(nx)
    chils[par] = result
  discard dfs(0)
 
dmp g
dmp chils
 
block:
  ans := 0
  went := makeSeq([N],false)
  proc dfs(par:int) =
    went[par] = true
    for e in g.adj[par]:
      nx := e.dst
      if went[nx]: continue
      dfs(nx)
    ans += (chils[par] + 1) * (N - chils[par] - 1)
  dfs(0)
  echo ans
 
