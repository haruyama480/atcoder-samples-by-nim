# #contest_doc
# name Tenkei90's_Last_Problem（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_cl
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/coef_of_generating_function
import atcoder/modint
 
type mint = modint998244353
 
input:
  (N,K): int

# 要理解
var f:FormalPowerSeries[mint] = @[mint(1)]
for t in 0 .. K << 1:
  var h = 1 - (f shl 1)
  if t > 0:
    let d = K div t
    h.resize(d + 1)
    var g = f / h
    g.resize(d + 1)
    f = g.move
  else:
    echo (f // h)[N]
