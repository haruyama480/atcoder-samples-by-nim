# #contest_doc
# name Don't_Leave_the_Spice（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ak
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar, bitops
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/lazysegtree, atcoder/modint

input:
    (W,N): int
    LRV[N]: (int, int, int)

type S = int
type F = int
proc op(l, r:S):S = max(l,r)
proc e():S = -int.inf
proc mapping(l:F, r:S):S = max(l,r)
proc composition(l, r:F):F = max(l,r)
proc id():F = -int.inf

# 香辛料ちょうどx mg使ったときの最大の価値
var a = makeSeq([W+1], -1)
a[0] = 0
var seg = init_lazy_segtree[S, F](a, op, e, mapping, composition, id)

for i in N:
    var (L,R,V) = LRV[i]
    var next = makeSeq([W+1], -1)
    for j in W+1:
        if L <= j:
            let h = seg.prod(max(j-R,0)..(j-L))
            if h >= 0:
                next[j] = h + V
    for j in W+1:
        seg.apply(j..j, max(next[j], seg.prod(j..j)))

echo seg.prod(W..W)
