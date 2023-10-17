import strutils, sequtils, hashes, sets, tables, sugar, strformat, algorithm

# Integers
assert 13 div 5 == 2
assert 13 mod 5 == 3
assert 1 shl 3 == 8
assert 8 shr 3 == 1

assert (0b0011 and 0b0101) == 0b0001
assert (0b0011 or 0b0101) == 0b0111

assert toInt(3.3) == 3

var x = 5
inc x
dec x
inc x, 3
dec x, 3
assert x == 5

# Strings
var str = "abc"; str.add('d')
assert str == "abcd"
assert "abc" & "def" == "abcdef"
assert ["xx","yy"].join(" ") == "xx yy"
assert ["xx","yy"] == "xx yy".split()
assert "abc".find('b') == 1
assert "abc".find("bc") == 1
assert "abc".find("x") == -1

# Sequences
assert toSeq(1..3) == @[1,2,3]
assert @str == @['a','b','c','d']
assert str[^2] == 'c'
assert @['a'] & @['b','c'] == @['a','b','c']
assert toSeq(1..3).repeat(2).foldl(a&b)[0..<5] == @[1,2,3,1,2]

proc double(x:int):int = 2*x
assert @[1,3].map(double) == @[2,6]
assert @[1,3].mapIt(2*it) == @[2,6]
proc condition(x:int):bool = (x mod 2) == 0
assert @[1,2,3].filter(condition) == @[2]
assert @[1,2,3].filterIt((it mod 2) == 0) == @[2]

# Bit sets
var a = {3..5}
a.incl 6
assert a == {3..6}
a.excl 4
assert a == {3,5,6}
assert {1,2} * {2,3} == {2}
assert {1,2} + {2,3} == {1,2,3}
assert {1,2} - {2,3} == {1}
assert {1,2} < {1,2,3}
assert not ({1,2} < {1,2})
assert {1,2} <= {1,2}

# Hashes
var h: Hash = 0
for i in 0..2:
  h = h !& hash(i) # mixing
h = !$h # end

# Hash sets
assert "acba".toHashSet == toHashSet(['a','b','c'])
assert initHashSet[int]() == toHashSet[int]([])
assert [1,2].toHashSet * [2,3].toHashSet == [2].toHashSet
assert [1,2].toHashSet + [2,3].toHashSet == [1,2,3].toHashSet
assert [1,2].toHashSet - [2,3].toHashSet == [1].toHashSet
assert [1,2].toHashSet < [1,2,3].toHashSet
assert not([1,2].toHashSet < [1,2].toHashSet)
assert [1,2].toHashSet <= [1,2].toHashSet
assert [1,2].toHashSet.len == 2
var xx  = [1,2,3].toHashSet
discard xx.pop() # random
assert xx.len == 2
assert not xx.containsOrIncl(9)
assert xx > [9].toHashSet
assert xx.containsOrIncl(9)
assert [1].toHashSet.toSeq == @[1]
for i, x in xx.toSeq:
  discard
assert @[0,1,2] == toSeq(1..5).mapIt(it div 2).deduplicate(isSorted=true) # ソート済みの場合はtrueで早くなる

# Hash tables
var _ = initTable[int,string]()
var b = toTable([(5,"ab"),(6,"cd")])
b[9] = "zz"
# discard b[0] # rise exception!
discard b.getOrDefault(0, "hoge")
assert b.contains(9)
assert b.hasKey(9)
b.del 9

assert toSeq([(5,"ab"),(6,"cd")].toTable.pairs) == @[(5,"ab"),(6,"cd")]
assert [5].toHashSet.toSeq == @[5]

var bb = initTable[int,int]()
bb[7] = bb.mgetOrPut(7, 0) + 1 # increment
assert bb[7] == 1

# Optionals
import options
var aa: Option[int] = none(int)
assert some(31).isSome
assert not some(31).isNone
assert none(int).isNone
assert not none(int).isSome
assert aa.get(-1) == -1
assert some(31).get(-1) == 31
assert some(31).filter(x => x==1).isNone # filterIt使えないのか
assert none(int).map(x => x*2).isNone # mapItも

# String formatting
let ss = "nim"
let ff = 987.12
assert fmt"{ss:5}" == "nim  "
assert fmt"{ss:<5}" == "nim  "
assert fmt"{ss:>5}" == "  nim"
assert fmt"{ss:^5}" == " nim "
assert fmt"{ff:8}" == "  987.12" # fがないので文字列としてformatされている
assert fmt"{ff:.1f}" == "987.1"
assert fmt"{ff:8.1f}" == "   987.1"
assert fmt"{ff:08.1f}" == "000987.1"
assert fmt"{ff:<8.1f}" == "987.1   "

# Algorithms
assert [40,50,60,70].binarySearch(50) == 1
assert [40,50,60,70].binarySearch(55) == -1
assert [40,50,60,70].lowerBound(50) == 1
assert [40,50,60,70].lowerBound(51) == 2 # 引数以上になる最初のindexが返る
assert [40,50,60,70].upperBound(50) == 2 # 引数を超える最初のindexが返る
var arr = toSeq(1..5)
assert arr.reversed == [5,4,3,2,1] # 非破壊的
arr.reverse # 破壊的
arr.sort # sortedもある
arr.fill(2,3,99) # filled　はない
assert arr == @[1,2,99,99,5]
arr.fill(0)
assert arr == @[0,0,0,0,0]

var arr2 = toSeq(1..5)
assert arr2.nextPermutation == true
assert arr2 == @[1,2,3,5,4]
arr2 = toSeq(1..5).reversed
assert arr2.nextPermutation == false # prevPermutation もある
assert arr2.rotatedLeft(1) == @[4,3,2,1,5] # rotatedRight　はない

import math
assert arr2.sum == 15
assert arr2.prod == 120
assert arr2.min == 1
assert arr2.max == 5

# countTable
var count = initCountTable[string]()
count.inc("DEC"); count.inc("DEC")
count.inc("ABC"); count.inc("ABC"); count.inc("ABC")
count.sort Descending
assert toSeq(count.pairs) == @[("ABC", 3), ("DEC", 2)]
count.sort Ascending
assert toSeq(count.pairs) == @[("DEC", 2), ("ABC", 3)]
for k, v in count:
  discard

# 双方向リンクリスト
import lists
# copied from: https://github.com/nim-lang/Nim/pull/16362/files
func copy*[T](a: DoublyLinkedList[T]): DoublyLinkedList[T] =
  result = initDoublyLinkedList[T]()
  for x in a.items:
    result.append(x)
proc addMoved*[T](a, b: var DoublyLinkedList[T]) =
  if b.head != nil:
    b.head.prev = a.tail
  if a.tail != nil:
    a.tail.next = b.head
  a.tail = b.tail
  if a.head == nil:
    a.head = b.head
  if a.addr != b.addr:
    b.head = nil
    b.tail = nil
proc add*[T: SomeLinkedList](a: var T, b: T) =
  var tmp = b.copy
  a.addMoved tmp
# copied end

var list1: DoublyLinkedList[int] = initDoublyLinkedList[int]()
list1.append(30); list1.append(40) # 末尾
list1.prepend(20); list1.prepend(10) # 頭
assert toSeq(list1) == @[10,20,30,40]
assert list1.find(20) != nil
list1.remove(list1.find(20))
for i, n in list1.items.toSeq:
  if n == 30:
    assert i == 1
list1.add list1
assert toSeq(list1) == @[10,30,40,10,30,40]

# キュー
import deques
var q : Deque[int] = initDeque[int]()
q.addFirst(1); q.addLast(2)
assert q.len == 2
assert q.peekFirst == 1 and q.peekLast == 2
assert q.popFirst == 1 and q.popLast == 2
assert q.len == 0

# ヒープ
import heapqueue
var heap = initHeapQueue[int]()
# var heap = [8, 2].toHeapQueue # nim 1.0.6だと使えない
heap.push(8); heap.push(2); heap.push(5)
assert heap[0] == 2
assert heap.pop() == 2
assert heap[0] == 5

# custom ヒープ
type Job = object
  priority: int
proc `<`(a, b: Job): bool = a.priority > b.priority
var jobs = initHeapQueue[Job]()
jobs.push(Job(priority: 1)); jobs.push(Job(priority: 2))
assert jobs[0].priority == 2
