when not declared HARULIB_GEOMETRY_CONVEX_HULL:
  const HARULIB_GEOMETRY_CONVEX_HULL* = 1

  import algorithm, sequtils, deques, math

  type Point = (int64,int64)

  proc outerProduct(a,b,c:Point): int64=
    let vx: Point = (b[0]-a[0],b[1]-a[1])
    let vy: Point = (c[0]-b[0],c[1]-b[1])
    vx[0] * vy[1] - vx[1] * vy[0]

  # 凸包の面積*2
  # 下に凸の場合、負の値なことに注意
  proc convexHullHalfArea*(p: seq[Point]): int64=
    if p.len <= 2: return 0
    for i in 1..<p.len-1:
      result += (-1) * outerProduct(p[0], p[i], p[i+1])

  # 線分上ある点の数
  proc linePointSize*(p: seq[Point]): int64=
    result.inc
    for i in 0..<p.len-1:
      let
        d0 = (p[i+1][0]-p[i][0]).abs
        d1 = (p[i+1][1]-p[i][1]).abs
      if d0 * d1 == 0:
        result += (d0 + d1)
      else:
        result += gcd(d0, d1)

  proc convexHull*(p:seq[Point]): auto=
    let n = p.len
    if n <= 2: return (p,p)

    var p = p.sortedByIt(it[0])

    var upper = initdeque[Point]()
    upper.addLast p[0]
    upper.addLast p[1]
    var
      i = 2
    while i < n:
      while upper.len > 1 and 
        ((outerProduct(upper[^2], upper[^1], p[i]) > 0) or
         # (4,6)->(4,0)->(4,4)と移動した場合、(4,0)をスルーする
         (upper[^2][0]==upper[^1][0] and upper[^1][0]==p[i][0] and upper[^1][1]<p[i][1] )
        ):
        upper.popLast
      upper.addLast p[i]
      i.inc

    var lower = initdeque[Point]()
    lower.addLast p[0]
    lower.addLast p[1]
    i = 2
    while i < n:
      while lower.len > 1 and 
        ((outerProduct(lower[^2], lower[^1], p[i]) < 0) or
         (lower[^2][0]==lower[^1][0] and lower[^1][0]==p[i][0] and lower[^1][1]>p[i][1] )
        ):
        lower.popLast
      lower.addLast p[i]
      i.inc

    return (upper.toSeq, lower.toSeq)

    # let area = (convexHullHalfArea(upper.toSeq) - convexHullHalfArea(lower.toSeq)) / 2
    # return (upper.toSeq, lower.toSeq, area)

