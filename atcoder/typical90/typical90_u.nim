# #contest_doc
# name Come_Back_in_One_Piece（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_u
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/scc
import atcoder/extra/other/sliceutils


input:
  (N,M): int
  AB[M]: (int1,int1)

var
  sc = initSccGraph(N)
for e in AB:
  sc.add_edge(e[0], e[1])
let a = sc.scc()

echo a.mapIt(it.len).filterIt(it>1).mapIt(it*(it-1) div 2).sum
