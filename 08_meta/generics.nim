type Container*[T] = object
    ## Generic type
    empty: bool
    value: T

type Comparable = concept a
    (a < a) is bool

proc newContainer*[T](e: bool, v: T): Container[T] =
    ## Generic type constructor
    Container[T](empty: e, value: v)

proc myMax*[T: SomeNumber](a, b: T): T =
    ## Generic max procedure.
    ## You can limit types accepted using the `[T: int | float]` syntax
    ## or you can use the "type classes", such as `SomeNumber`.
    ## The full list of type classes is defined in the
    ## [System module](https://nim-lang.org/docs/system.html):
    if a < b:
        return b
    else:
        return a

proc conceptMax*[T: Comparable](a, b: T): T =
    if a < b:
        return b
    else:
        return a

assert myMax(5, 10) == 10
assert myMax(31.3, 1.23124) == 31.3
assert conceptMax("Hello", "World") == "World"
assert conceptMax(5, 10) == 10

# Try omitting `[float]` below and see what kind of error you get
assert myMax[float](5, 10.3) == 10.3
assert myMax(5.0, 10.3) == 10.3

let b = Container[int](empty: true)
let c = newContainer[int](false, 10)
let d = newContainer[int](true, 0)
assert b is Container[int]
assert b == Container[int](empty: true, value: 0)
assert c == Container[int](empty: false, value: 10)
assert b == d
