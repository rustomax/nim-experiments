import macros

#dumpTree:
#  5 * 5 + 10

macro calculate(): int =
  infix(
    infix(
      newIntLitNode 5,
      "*",
      newIntLitNode 5
    ),
    "+",
    newIntLitNode 10  
  )

macro arguments(number: int, unknown: untyped): untyped =
  result = newStmtList()
  echo number.treeRepr()
  echo unknown.treeRepr()

#echo calculate()
arguments(42, ["hello", "world"])
