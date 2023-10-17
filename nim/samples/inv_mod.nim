import atcoder/modint
type mint = modint1000000007
const MOD = 1000000007

# x^-1 == x^(MOD-2) を最小2乗法で求める
proc invf(x:mint):mint =
  result = mint(1)
  var aa = x
  var n: int = MOD-2
  while n > 0:
    if n mod 2 != 0:
      result *= aa
    aa *= aa
    n = n div 2

# N までの逆元は O(N) で計算できる
const N = 100
var inv = newSeq[mint](N)
inv[1] = 1
for i in 2..<N:
  inv[i] = (MOD - MOD div i) * inv[MOD mod i]

for i in 1..<N:
  assert inv[i]*i == 1
