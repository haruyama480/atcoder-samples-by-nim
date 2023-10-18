# #contest_doc
# name Subtree
# url https://atcoder.jp/contests/dp/tasks/dp_v
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/graph/graph_template
import harulib/modint
declareDMint(mint)

input:
  (N,M): int
  XY[N-1]: (int1, int1)
mint.setMod(M)

var g = initGraph(N)
for xy in XY: g.addBiEdge(xy[0], xy[1])

var dp1 = makeSeq([N], 1.mint) # 頂点vが黒色で題意の連結を満たす通り数
proc dfs1(t, par: int)=
  for e in g[t]:
    var e = e.dst
    if e == par: continue
    dfs1(e, t)
    dp1[t] *= dp1[e] + 1 
dfs1(0, -1)

var dp2 = makeSeq([N], 1.mint) # 頂点vの親が黒色で題意の連結を満たす通り数
proc dfs2(t, par: int )=
  if g[t].len == 1: return

  var
    cumf = makeSeq([g[t].len+1], 1.mint)
    i = 0
  for e in g[t]:
    var e = e.dst
    if e == par: cumf[i+1] = cumf[i]
    dfs2(e, t)
    cumf[i+1] = cumf[i]*dp1[e]
    i.inc

  var
    cumb = makeSeq([g[t].len+1], 1.mint)
  for e in g[t].reversed:
    var e = e.dst
    if e == par: cumb[i-1] = cumb[i]
    dfs2(e, t)
    cumb[i-1] = cumb[i]*dp1[e]
    i.dec

  i = 0
  for e in g[t]:
    var e = e.dst
    if e == par: continue
    dfs2(e, t)
    dp2[e] = cumf[i] * cumb[i+1]
    i.inc
dfs2(0, -1)

dmp dp1
dmp dp2
