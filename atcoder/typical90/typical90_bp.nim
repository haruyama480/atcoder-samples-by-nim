# #contest_doc
# name Paired_Information（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bp
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/dsu

input:
  N: int
  Q: int
  TXYV[Q]: (int, int1, int1, int)
 
dmp (N,Q)
dmpi TXYV
 
var T = TXYV.mapIt(it[0])
var X = TXYV.mapIt(it[1])
var Y = TXYV.mapIt(it[2])
var V = TXYV.mapIt(it[3])
 
# クエリ先読み
chain := makeSeq([N-1], 0)
for i in Q:
  if T[i] == 1: continue
  chain[X[i]] = V[i]
dmp chain
 
buf := makeSeq([N], 0)
for i in 1..<N:
  buf[i]=chain[i-1]-buf[i-1] # Ambiguousは後で弾くので雑に全算出
dmp buf
 
var uf = initDSU(N)
for i in Q:
  if T[i] == 0:
    uf.merge(X[i], Y[i])
    continue
  if not uf.same(X[i], Y[i]):
    echo "Ambiguous"
  else:
    if (Y[i] - X[i]) mod 2 == 0:
      echo buf[Y[i]] + V[i] - buf[X[i]]
    else:
      echo buf[Y[i]] - V[i] + buf[X[i]]
 
