when not declared HARULIB_MATH_DIVISOR:
  const HARULIB_MATH_DIVISOR* = 1

  import math

  # # 素因数分解
  proc prime_factorization*(x:int64):seq[(int64, int)] =
    if x == 1: return
    var x = x
    let maxp = (x+1).float64.sqrt.int64
    for p in 2..maxp:
      var cnt = 0
      while x mod p == 0:
        x = x div p
        cnt.inc
      if cnt > 0:
        result.add((p, cnt))
    if x != 1:
      result.add((x, 1))

  # 約数羅列
  proc divisor*(x: int64):seq[int64]=
    for d in 1..x:
      if d*d > x: break
      if x mod d == 0:
        result.add d
    var dlen = result.len
    if result[^1]*result[^1] == x: dlen.dec
    for i in countdown(dlen-1,0):
      result.add x div result[i]
