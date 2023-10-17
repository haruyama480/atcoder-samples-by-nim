# #contest_doc
# name Avoid_War（★7）
# url https://atcoder.jp/contests/typical90/tasks/typical90_w
# version 0.0.1

{. warning[UnusedImport]:off .}
import sequtils, math, algorithm, strutils, strformat, bitops, deques, heapqueue, hashes, sets, tables, lists
import harulib/utils
import atcoder/extra/other/sliceutils

input:
  (H,W): int
  C[H]: chars

dmp (H,W)
dmpi C

const maxlen = 2^24 # > 855529. 衝突を避けるために大きめに設定しておく
b2i := initTable[int, int](maxlen) # bit値 から index へ
i2b := makeSeq([855529+100], 0)
i2newb := makeSeq([855529+100], 0)
i2dec := makeSeq([855529+100], 0)
i2inc := makeSeq([855529+100], 0)

template hasSingleBit(x: int): bool =
  x.bitand(-x) == x

cnt := 0
for i in 2^(W+1):
  if (2^W+1).bitand(i) != (2^W+1) and (i shl 1).bitand(i).hasSingleBit():
    b2i[i] = cnt
    i2b[cnt] = i
    i2newb[cnt] = (i div 2) + 2^W
    cnt.inc
dmp cnt
bitW := b2i.len

for i in bitW:
  if b2i.hasKey(i2b[i] div 2):
    i2dec[i] = b2i[i2b[i] div 2]
  if b2i.hasKey((i2b[i] div 2) + 2^W):
    i2inc[i] = b2i[(i2b[i] div 2) + 2^W]

i2skip := makeSeq([W, 855529+100], false)
for i in W:
  for k in bitW:
    prebits := i2b[k]
    newbits := i2newb[k]
    if (not b2i.hasKey(newbits)) or (newbits.bitand(1) == 1) or (i != 0 and (prebits.bitand(1) == 1 or prebits.bitand(2^W) == 2^W)) or (i != (W-1) and newbits.bitand(2) == 2):
      i2skip[i][k] = true


dp := makeSeq([2, b2i.len], 0)
MOD := 10^9 + 7
for j in H:
  for i in W:
    if i == 0 and j == 0:
      dp[0][0] = 1
      if C[j][i] == '.':
        dp[0][b2i[2^W]] = 1
    else:
      next_dp := (j*W+i) mod 2
      prev_dp := (j*W+i-1) mod 2
      dp[next_dp].fill(0)
      noskipcell := C[j][i] != '#'
      for k in bitW:
        # dp[pos][mask] → dp[pos+1][floor(mask)/2], dp[pos+1][floor(mask)/2 + 2^W]
        dp[next_dp][i2dec[k]] += dp[prev_dp][k] # MODをサボる
        if noskipcell and (not i2skip[i][k]):
          newposi := i2inc[k]
          dp[next_dp][newposi] = (dp[next_dp][newposi] + dp[prev_dp][k]) mod MOD

if W < 5:
  dmp b2i
  dmpi dp

ans := 0
for k in bitW:
  ans = (ans + dp[(H*W-1) mod 2][k]) mod MOD
echo ans
