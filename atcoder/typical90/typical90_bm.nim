# #contest_doc
# name RGB_Balls_2（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bm
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/modint
 
type mint = modint998244353

input:
  (R,G,B,K): int
  (X,Y,Z): int

const MAX = 200020

var fct = makeSeq([MAX],mint(1))
for i in 1..<MAX: fct[i] = i*fct[i-1]

proc comb(i,j: int):mint=
  assert i >= j
  fct[i] / fct[j] / fct[i-j]


let blue = block:
  var f = makeSeq([B+1],mint(0))
  for i in (K-X)..B: f[i] = comb(B,i)
  initFormalPowerSeries(f)
let red = block:
  var f = makeSeq([R+1],mint(0))
  for i in (K-Y)..R: f[i] = comb(R,i)
  initFormalPowerSeries(f)
let green = block:
  var f = makeSeq([G+1],mint(0))
  for i in (K-Z)..G: f[i] = comb(G,i)
  initFormalPowerSeries(f)

var f:FormalPowerSeries[mint] = @[mint(1)]
f *= blue * red * green
dmp f

echo f[K]
