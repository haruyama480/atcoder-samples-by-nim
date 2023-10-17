# #contest_doc
# name Discrete_Dowsing（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ba
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/header

let fibs = @[2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597]

proc calcM1(m0, m3: int): int=
  # m3-m0=fib数-1
  let d = m3 - m0 + 1
  var n = 0
  for i in fibs.len:
    if fibs[i] > d:
      n=i; break
  if n <= 1:
    return m0
  else:
    return m0+fibs[n-2]-1

proc calcM2(m0, m3: int): int=
  let d = m3 - m0 + 1
  var n = 0
  for i in fibs.len:
    if fibs[i] > d:
      n=i; break
  if n == 0:
    return m3
  else:
    return min(m0+fibs[n-1]-1,m3)


let T = nextInt()
for _ in T:
  let N = nextInt()
  if N < 0: break
  
  var
    m0 = 0
    m3 = N-1
    m1 = calcM1(m0,m3)
    m2 = calcM2(m0,m3)
    (a1, a2) = (-1, -1)

  echo fmt"? {m1+1}"
  a1 = nextInt()
  dmp (m1,a1)
  if N == 1:
    echo fmt"! {a1}"
    continue

  var foreward = true
  while true:
    dmp (m0,m1,m2,m3)
    if foreward:
      echo fmt"? {m2+1}"
      a2 = nextInt()
      dmp (m2,a2)
    else:
      echo fmt"? {m1+1}"
      a1 = nextInt()
      dmp (m1,a1)
    
    if m3 - m0 <= 1:
      let ans = max(a1,a2)
      echo fmt"! {ans}"
      break
    
    if a1 < a2:
      foreward = true
      m0 = m1+1
      m1 = m2; a1 = a2
      m2 = calcM2(m0,m3)
      if m1 == m2:
        foreward = false
        m1 = calcM1(m0,m3)
    else:
      foreward = false
      m3 = m2-1
      m2 = m1; a2 = a1
      m1 = calcM1(m0,m3)
    

