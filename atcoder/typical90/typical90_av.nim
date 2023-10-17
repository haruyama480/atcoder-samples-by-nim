# #contest_doc
# name I_will_not_drop_out（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_av
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (N,K):int
  AB[N]: (int, int)
 
 
type Job = (int, int)
proc `<`(a, b: Job): bool = a[0] > b[0]
 
priq := initHeapQueue[Job]()
 
for i in N:
  priq.push((AB[i][1], i))
 
ans := 0
for i in K:
  var (score, j) = priq.pop()
  if j >= 0:
    priq.push((AB[j][0]-AB[j][1], -1))
  ans += score
echo ans
 