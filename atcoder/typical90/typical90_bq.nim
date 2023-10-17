# #contest_doc
# name Colorful_Blocks_2（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_bq
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists, sugar
import harulib/utils
import atcoder/extra/other/sliceutils
import atcoder/modint

type mint = modint1000000007
 
input:
  (N,K): (int64, int)
 
# (K-2)^(N-2) * (K-1) * K
case N:
of 1:
  echo K
of 2:
  echo mint(K-1)*K
else:
  echo mint(K-2).pow(N-2)*(K-1)*K
 