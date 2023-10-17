when not declared HARULIB_UTILS:
  const HARULIB_UTILS* = 1

  {.hints:off warnings:off assertions:on optimization:speed checks:off.}

  import macros

  const DO_DUMP{.booldefine.} = false
  macro dmp*(x: typed): untyped =
    when DO_DUMP:
      let s = x.toStrLit
      let r = quote do:
        stderr.writeLine `s`, " = ", `x`
      return r
    else:
      return quote do:
        discard
  proc dmpi*[T](xs: openArray[T]) =
    when DO_DUMP:
      for x in xs:
        stderr.writeLine "  ", x
    else:
      discard

  # char
  proc `-`*(a, b: char): int = a.int - b.int
  proc `+`*(a: char, b: int): char = (a.ord + b).chr
  proc `+`*(a: int, b: char): char = (a + b.ord).chr

  import sequtils
  iterator iota*(n: int): int =
    for i in 0..<n: yield i
  proc zipWithIndices*[T](xs: openArray[T]): seq[tuple[a: int, b: T]] =
    zip(toSeq(iota(xs.len)), xs)

  # subsets
  import bitops
  proc bits*(x,i: SomeInteger): bool=
    x.bitand(1 shl i) > 0
  iterator subbits*(allbit:SomeInteger):SomeInteger =
    var sub = allbit
    while sub > 0:
      yield sub
      sub = (sub - 1).bitand(allbit)
    yield 0
    # assert toSeq(0b1010.subbits) == @[0b1010,0b1000,0b0010,0b0000]
  iterator subkbits*(n,k:SomeInteger):SomeInteger =
    var comb = (1 shl k) - 1
    while (comb < (1 shl n)):
      yield comb
      let
        x = comb.bitand(comb.bitnot + 1)
        y = comb + x
      comb = (((comb.bitand(y.bitnot)) div x) shr 1).bitor(y)
    # assert toSeq(subkbits(4,3)) == @[0b0111,0b1011,0b1101,0b1110]
  proc bitvals*(seed,len: SomeInteger):seq[SomeInteger] =
    toSeq(len.iota).filterIt(bitand(seed shr it, 1)==1)
    # assert bitvals(255,4) == @[0,1,2,3]
  
  # thanks: https://rosettacode.org/wiki/Matrix_transposition
  # transpose(A[i][j][...]) = A[j][i][...]
  proc transpose*[T](s: seq[seq[T]]): seq[seq[T]] =
    result = newSeq[seq[T]](s[0].len)
    for i in 0 .. s[0].high:
      result[i] = newSeq[T](s.len)
      for j in 0 .. s.high:
        result[i][j] = s[j][i]

  # thanks: yuly3
  proc transLastStmt(n, res, bracketExpr: NimNode): (NimNode, NimNode, NimNode) =
    # Looks for the last statement of the last statement, etc...
    case n.kind
    of nnkIfExpr, nnkIfStmt, nnkTryStmt, nnkCaseStmt:
      result[0] = copyNimTree(n)
      result[1] = copyNimTree(n)
      result[2] = copyNimTree(n)
      for i in ord(n.kind == nnkCaseStmt)..<n.len:
        (result[0][i], result[1][^1], result[2][^1]) = transLastStmt(n[i], res, bracketExpr)
    of nnkStmtList, nnkStmtListExpr, nnkBlockStmt, nnkBlockExpr, nnkWhileStmt,
        nnkForStmt, nnkElifBranch, nnkElse, nnkElifExpr, nnkOfBranch, nnkExceptBranch:
      result[0] = copyNimTree(n)
      result[1] = copyNimTree(n)
      result[2] = copyNimTree(n)
      if n.len >= 1:
        (result[0][^1], result[1][^1], result[2][^1]) = transLastStmt(n[^1], res, bracketExpr)
    of nnkTableConstr:
      result[1] = n[0][0]
      result[2] = n[0][1]
      if bracketExpr.len == 1:
        bracketExpr.add([newCall(bindSym"typeof", newEmptyNode()), newCall(
            bindSym"typeof", newEmptyNode())])
      template adder(res, k, v) = res[k] = v
      result[0] = getAst(adder(res, n[0][0], n[0][1]))
    of nnkCurly:
      result[2] = n[0]
      if bracketExpr.len == 1:
        bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
      template adder(res, v) = res.incl(v)
      result[0] = getAst(adder(res, n[0]))
    else:
      result[2] = n
      if bracketExpr.len == 1:
        bracketExpr.add(newCall(bindSym"typeof", newEmptyNode()))
      template adder(res, v) = res.add(v)
      result[0] = getAst(adder(res, n))

  macro collect*(init, body: untyped): untyped =
    runnableExamples:
      import sets, tables
      let data = @["bird", "word"]
      ## seq:
      let k = collect(newSeq):
        for i, d in data.pairs:
          if i mod 2 == 0: d
      assert k == @["bird"]
      ## seq with initialSize:
      let x = collect(newSeqOfCap(4)):
        for i, d in data.pairs:
          if i mod 2 == 0: d
      assert x == @["bird"]
      ## HashSet:
      let y = initHashSet.collect:
        for d in data.items: {d}
      assert y == data.toHashSet
      ## Table:
      let z = collect(initTable(2)):
        for i, d in data.pairs: {i: d}
      assert z == {0: "bird", 1: "word"}.toTable
    
    let res = genSym(nskVar, "collectResult")
    expectKind init, {nnkCall, nnkIdent, nnkSym}
    let bracketExpr = newTree(nnkBracketExpr,
      if init.kind == nnkCall: init[0] else: init)
    let (resBody, keyType, valueType) = transLastStmt(body, res, bracketExpr)
    if bracketExpr.len == 3:
      bracketExpr[1][1] = keyType
      bracketExpr[2][1] = valueType
    else:
      bracketExpr[1][1] = valueType
    let call = newTree(nnkCall, bracketExpr)
    if init.kind == nnkCall:
      for i in 1 ..< init.len:
        call.add init[i]
    result = newTree(nnkStmtListExpr, newVarStmt(res, call), resBody, res)

  # thanks: zer0-star
  include prelude
  {.warning[UnusedImport]: off.}
  import sequtils, math, algorithm, strformat, bitops, deques, heapqueue
  import sugar

  iterator items*(n:int64):int64 = (for i in 0..<n: yield i)
  iterator range*(x, y: int): int {.inline.} =
    var res = x
    while res < y:
      yield res
      inc(res)
  iterator range*(x: int): int {.inline.} =
    var res = 0
    while res < x:
      yield res
      inc(res)
  proc range*(x, y: int): seq[int] {.inline.} =
    toSeq(x..y-1)
  proc range*(x: int): seq[int] {.inline.} =
    toSeq(0..x-1)
  proc discardableId[T](x: T): T {.inline, discardable.} =
    return x
  macro `:=`*(x, y: untyped): untyped =
    if (x.kind == nnkIdent):
      return quote do:
        when declaredInScope(`x`):
          `x` = `y`
        else:
          var `x` = `y`
        discardableId(`x`)
    else:
      return quote do:
        `x` = `y`
        discardableId(`x`)
  proc `mod=`*(a :var SomeInteger, b :SomeInteger) = a = a mod b
  proc `div=`*(a :var SomeInteger, b :SomeInteger) = a = a div b
  proc `bitand=`*(a :var SomeInteger, b :SomeInteger) = a = a.bitand b
  proc `bitor=`*(a :var SomeInteger, b :SomeInteger) = a = a.bitor b
  proc `bitxor=`*(a :var SomeInteger, b :SomeInteger) = a = a.bitxor b
  proc `&=`*(a :var SomeInteger, b :SomeInteger) = a = a.bitand b
  proc `|=`*(a :var SomeInteger, b :SomeInteger) = a = a.bitor b
  proc divmod*(x, y: SomeInteger): (int, int) =
    (x div y, x mod y)
  proc `min=`*[T](x: var T; y: T): bool {.discardable.} =
    if x > y:
      x = y
      return true
    else:
      return false
  proc `max=`*[T](x: var T; y: T): bool {.discardable.} =
    if x < y:
      x = y
      return true
    else:
      return false
  template inf*(T): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: T.high div 2
    else: assert(false)

  proc parseInnerType(x: NimNode): NimNode =
    newIdentNode("parse" & x[1].repr)

  proc inputAsTuple(ty: NimNode): NimNode =
    result = nnkStmtListExpr.newTree()
    t := genSym()
    result.add quote do: (let `t` = stdin.readLine.split)
    var p : NimNode
    if ty.kind == nnkPar:
      p = nnkPar.newTree()
    elif ty.kind == nnkTupleConstr:
      p = nnkTupleConstr.newTree()
    for i, typ_tmp in ty.pairs:
      var ece, typ: NimNode
      if typ_tmp.kind == nnkExprColonExpr:
        ece = nnkExprColonExpr.newTree(typ_tmp[0])
        typ = typ_tmp[1]
      else:
        ece = nnkExprColonExpr.newTree(ident("f" & $i))
        typ = typ_tmp
      if typ.repr == "string":
        ece.add quote do: `t`[`i`]
      else:
        parsefn := newIdentNode("parse" & typ.repr)
        ece.add quote do: `t`[`i`].`parsefn`
      p.add ece
    result.add p

  macro inputAsType(ty: untyped): untyped =
    if ty.kind == nnkBracketExpr:
      if ty[1].repr == "string":
        return quote do: stdin.readLine.split
      else:
        parsefn := parseInnerType(ty)
        return quote do: stdin.readLine.split.map(`parsefn`)
    elif ty.kind == nnkTupleConstr or ty.kind == nnkPar: # support Nim version < 1.6.0
      return inputAsTuple(ty)
    elif ty.repr == "string":
      return quote do: stdin.readLine
    else:
      parsefn := ident("parse" & ty.repr)
      return quote do: stdin.readLine.`parsefn`

  macro input*(query: untyped): untyped =
    doAssert query.kind == nnkStmtList
    result = nnkStmtList.newTree()
    letSect := nnkVarSection.newTree()
    for defs in query:
      if defs[0].kind == nnkIdent:
        tmp := nnkIdentDefs.newTree(defs[0], newEmptyNode())
        typ := defs[1][0]
        var val: NimNode
        if typ.len <= 2:
          val = quote do: inputAsType(`typ`)
        else:
          op := typ[2]
          typ.del(2, 1)
          val = quote do: inputAsType(`typ`).mapIt(`op`)
        if defs[1].len > 1:
          op := defs[1][1]
          it := ident"it"
          tmp.add quote do:
            block:
              var `it` = `val`
              `op`
        else:
          tmp.add val
        letSect.add tmp
      elif defs[0].kind == nnkTupleConstr or defs[0].kind == nnkPar:
        vt := nnkVarTuple.newTree()
        for id in defs[0]:
          vt.add id
        vt.add newEmptyNode()
        sle := nnkStmtListExpr.newTree()
        t := genSym()
        sle.add quote do: (let `t` = stdin.readLine.split)
        var p: NimNode
        if defs[0].kind == nnkTupleConstr:
          p = nnkTupleConstr.newTree()
        else: 
          # defs[0].kind == nnkPar
          # support Nim version < 1.6.0
          p = nnkPar.newTree()
        if defs[1][0].kind == nnkTupleConstr or defs[1][0].kind == nnkPar:
          for i, typ in defs[1][0].pairs:
            if typ.repr == "string":
              p.add quote do: `t`[`i`]
            else:
              parsefn := newIdentNode("parse" & typ.repr)
              p.add quote do: `t`[`i`].`parsefn`
        else:
          typ := defs[1][0]
          if typ.repr == "string":
            for i in 0..<defs[0].len:
              p.add quote do: `t`[`i`]
          else:
            parsefn := newIdentNode("parse" & typ.repr)
            for i in 0..<defs[0].len:
              p.add quote do: `t`[`i`].`parsefn`
        sle.add p
        vt.add sle
        letSect.add vt
      elif defs[0].kind == nnkBracketExpr:
        ids := nnkIdentDefs.newTree(defs[0][0], newEmptyNode())
        cnt := defs[0][1]
        typ := defs[1][0]
        var input: NimNode
        if typ.kind == nnkBracketExpr and typ.len > 2:
          op := typ[2]
          typ.del(2, 1)
          input = quote do: inputAsType(`typ`).mapIt(`op`)
        else:
          input = quote do: inputAsType(`typ`)
        var val: NimNode
        if defs[0].len > 2:
          op := defs[0][2]
          it := ident"it"
          val = quote do:
            block:
              var `it` = `input`
              `op`
        else:
          val = input
        if defs[1].len > 1:
          op := defs[1][1]
          it := ident"it"
          ids.add(quote do:
            block:
              var `it` = newSeqWith(`cnt`, `val`)
              `op`)
        else:
          ids.add(quote do: newSeqWith(`cnt`, `val`))
        letSect.add ids
      else:
        # for debug
        result.add (
          nnkCommand.newTree(
            newDotExpr(newIdentNode("stderr"), newIdentNode("writeLine")),
            newLit(defs[0].kind)
          )
        )
    result.add letSect

  proc makeSeq*[T, Idx](num: array[Idx, int]; init: T): auto =
    when num.len == 1:
      return newSeqWith(num[0], init)
    else:
      var tmp: array[num.len-1, int]
      for i, t in tmp.mpairs: t = num[i+1]
      return newSeqWith(num[0], makeSeq(tmp, init))

  proc parseInt1*(str: string): int =
    str.parseInt - 1

  proc parseInt64*(str: string): int64 =
    str.parseBiggestInt

  proc parseNatural*(str: string): Natural =
    max(str.parseInt, 0)

  proc parseChars*(str: string): seq[char] =
    toSeq(str.items)

  proc parseChar*(str: string): char =
    char(str[0])
  discard

