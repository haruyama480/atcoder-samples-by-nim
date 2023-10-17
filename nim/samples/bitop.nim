import bitops,sequtils

assert 7.bitand(6) == 6
assert 1.bitor(7) == 7
assert 1.bitxor(7) == 6
assert 1.bitnot().bitand(255) == 254

iterator subbits*(allbit:SomeInteger):SomeInteger =
  var sub = allbit
  while sub > 0:
    yield sub
    sub = (sub - 1).bitand(allbit)
  yield 0
assert toSeq(0b1010.subbits) == @[0b1010,0b1000,0b0010,0b0000]

iterator subkbits*(n,k:SomeInteger):SomeInteger =
  var comb = (1 shl k) - 1
  while (comb < (1 shl n)):
    yield comb
    let
      x = comb.bitand(comb.bitnot + 1)
      y = comb + x
    comb = (((comb.bitand(y.bitnot)) div x) shr 1).bitor(y)
assert toSeq(subkbits(4,3)) == @[0b0111,0b1011,0b1101,0b1110]
