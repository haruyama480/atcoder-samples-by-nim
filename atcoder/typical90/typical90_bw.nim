# #contest_doc
# name Magic_For_Balls（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bw
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint
import atcoder/extra/graph/graph_template

# 素因数のlog2
 
input:
  N: int64
 
n := N
var cnt = 0
for p in 2..N:
  if n == 1 or p^2 > N: break
  while n mod p == 0:
    dmp p
    cnt.inc
    n.div= p
if n != 1:
  cnt.inc
dmp (N, cnt)
 
proc log2int(x: int): int=
  x := x
  while x > 1:
    x = (x+1) div 2
    result.inc
echo log2int(cnt)
 