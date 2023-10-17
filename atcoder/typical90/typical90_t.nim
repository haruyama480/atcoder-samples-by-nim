# #contest_doc
# name Log_Inequality（★3）
# url https://atcoder.jp/contests/typical90/tasks/typical90_t
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue
import sugar
import harulib/utils

input:
  (a,b,c): Natural

dmp (a, c^b)
if a < c^b:
  echo "Yes"
else:
  echo "No"
