import atcoder/modint
type mint = modint1000000007
const MOD = 1000000007

const FRAC_N = 1000

# 階乗を計算しておく
var frac = newSeq[mint](FRAC_N)
frac[0] = 1
for i in 1..<FRAC_N:
  frac[i] = frac[i-1]*i

# x^-1 == x^(MOD-2) を最小2乗法で求める
proc inv(x:mint):mint =
  result = mint(1)
  var aa = x
  var n: int = MOD-2
  while n > 0:
    if n mod 2 != 0:
      result *= aa
    aa *= aa
    n = n div 2

assert mint(100) * inv(mint(100)) == 1

# Permutation
# P(N,K) = N! / K!
proc perm(n:int, k:int): mint=
  frac[n] * inv(frac[k])
assert perm(100,97) == 970200

# Combination
# C(N,K) = N! / (K! * (N-K)!)
proc comb(n:int, k:int): mint=
  frac[n] * inv(frac[k]*frac[n-k])
assert comb(100,97) == 161700
