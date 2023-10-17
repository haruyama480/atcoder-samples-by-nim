# #contest_doc
# name Long_Bricks（★5）
# url https://atcoder.jp/contests/typical90/tasks/typical90_ac
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets
import sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/lazysegtree, atcoder/modint

input:
  (W, N): int
  LR[N]: (int1, int1)

type S = int
type F = int

proc op(l, r:S):S = max(l,r)
proc e():S = 0
proc mapping(l:F, r:S):S = max(l,r)
proc composition(l, r:F):F = max(l,r)
proc id():F = 0

var a = makeSeq([W], 0)
var seg = init_lazy_segtree[S, F](a, op, e, mapping, composition, id)

for (l,r) in LR:
  let h = seg.prod(l..r)
  seg.apply(l..r, h+1)
  echo h+1
