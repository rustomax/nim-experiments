import sequtils, sugar

proc doubleSeq*[T: SomeNumber](s: seq[T]): seq[T] =
    ## Generic procedure taking a sequence of any numeric type,
    ## and returning a new sequence with every element doubled.
    ## The argument is assed by value, so it is immutable inside the procedure.
    s.map(x => x * 2)

proc mDoubleSeq*[T: SomeNumber](s: var seq[T]) =
    ## The argument is passed as `var` (mutable reference),
    ## so we can change the sequence in place
    for v in s.mitems():
        v *= 2

proc mTripleIt*[T: SomeNumber](s: var openArray[T]) =
    ## OpenArray is a wrapper for both arrays and sequences,
    ## so this procedure will accept any such argument.
    for i in 0..s.high:
        s[i] *= 3
        
## One way to create a sequence is with the newSeq macro.
## Notice the empty parentheses `()`. Compiler will complain without them.
var a = newSeq[int]()
assert a == @[] ## `a` is an empty sequence
for i in 1..5:
    a.add(i * 3)
assert a == @[3, 6, 9, 12, 15]

## Same, but using sugar and sequtils (more consize).
let b = toSeq(1..5).map(x => x * 3)
assert a == b

## Or you can simply take an array and convert it to sequence,
## using the `@` operator. Notice type inference at work.
let c = @[3, 6, 9, 12, 15]
assert c == b

## `c` is immutable inside `doubleSeq()` becaused it's passed by value.
## Plus it's an immutable variable created with `let` to start with.
assert c.doubleSeq() == @[6, 12, 18, 24, 30]
assert c == @[3, 6, 9, 12, 15]

## `a` is mutable inside `mDoubleSeq`
a.mDoubleSeq()
assert a == @[6, 12, 18, 24, 30]

a.mTripleIt()
assert a == @[18, 36, 54, 72, 90]