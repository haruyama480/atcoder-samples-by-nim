# #contest_doc
# name Monochromatic_Diagonal（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_au
# version 0.0.1

# 参考: chaemonさん https://atcoder.jp/contests/typical90/submissions/35052151

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/string/rolling_hash
 
input:
  N: int
  S: string
  T: string

var T0, T1, T2 = T
# R <-> G
for t in T0.mitems:
  if t == 'R': t = 'G'
  elif t == 'G': t = 'R'
# G <-> B
for t in T1.mitems:
  if t == 'G': t = 'B'
  elif t == 'B': t = 'G'
# B <-> R
for t in T2.mitems:
  if t == 'B': t = 'R'
  elif t == 'R': t = 'B'
var
  r = initRollingHash(S)
  r0 = initRollingHash(T0)
  r1 = initRollingHash(T1)
  r2 = initRollingHash(T2)
  ans = 0

for i in N:
  let 
    l = i + 1
    h = r[0..<l]
  if r0[^l..^1] == h or r1[^l..^1] == h or r2[^l..^1] == h:
    ans.inc

for i in 1..<N:
  let 
    l = i
    h = r[^l..^1]
  if r0[0..<l] == h or r1[0..<l] == h or r2[0..<l] == h:
    ans.inc

echo ans
