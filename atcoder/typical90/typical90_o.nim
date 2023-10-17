# #contest_doc
# name Don't_be_too_close（★6）
# url https://atcoder.jp/contests/typical90/tasks/typical90_o
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/extra/other/seq_array_utils
import atcoder/extra/other/bitutils
import atcoder/modint
type mint = modint1000000007
const MOD = 1000000007

input:
  N: int

proc modpow(a, b: mint): mint =
  var
    pp = mint(1)
    q = a
  for i in 32:
    if ((b.val & (1 << i)) != 0):
      pp *= q
    q *= q
  pp

proc `///`(a, b: mint): mint =
  a * modpow(b, mint(MOD - 2))

var perm = newSeqWith(N+1, mint(1))
for i in 2..N:
  perm[i] = perm[i-1] * mint(i)

for k in 1..N:
  var ans = mint(0)
  for a in 1..N:
    if N-(k-1)*(a-1) < a:
      break
    # 差がk、取るボールがa個のとき、考えられる組み合わせは {}_{N-(k-1)(a-1)) C_{a}
    ans += perm[N-(k-1)*(a-1)] /// (perm[a] * perm[N-(k-1)*(a-1)-a])

  echo ans.val
