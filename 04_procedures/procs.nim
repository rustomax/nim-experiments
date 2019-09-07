## Demonstrates Nim procedures

import sequtils, sugar

proc add*(x, y: int): int =
    ## Returns the sum of two integers. Doesn't get any simpler than this.
    x + y

proc sum*(nums: varargs[int]): int =
    ## * `result` variable will be implicitly returned 
    ##   at the end of the procedure's execution.
    ## * `varargs` allows passing a variable number of arguments of the same type.
    for n in nums:
        result += n

proc genSum*[T](args: varargs[T]): T =
    ## Making our summation procedure more robust with the use of generics.
    ## Now `genSum()` will take arguments of any type `T` for which addition is defined.
    for n in args:
        result = result + n

proc `+`*(a, b: string): string =
    ## In Nim, you can overload operators or even create your own!
    ## To make our `genSum()` function be able to take `string` arguments,
    ## we need to overload `+` operator for strings. Notice that in `genSum()`,
    ## we also have to change `result += n` to `result = result + n`,
    ## since only `+`, not `+=` is overloaded for `string` arguments.
    result = a & b

proc double*(a: var openArray[int]) =
    ## Multiplies each member of an array or a sequence by 2.
    ## Notice that the formal parameter for the array is defined
    ## as `var`. By default, function arguments are immutable
    ## in the fuction's body and need to be explicitly annotated with `var`
    ## to become mutable.
    ## 
    ## Exercise: try removing `var` in function signature and see what kind of 
    ## error message the compiler will generate.
    ## 
    for elem in a.mitems():
        elem *= 2

proc demo*() =
    assert add(2, 3) == 5
    assert sum(1, 2, 3, 4) == 10
    assert genSum(0.5, 2.3, 1.0) == 3.8
    assert genSum(5, 9, 1, 8, 3) == 26
    assert genSum("Hello", " ", "World!") == "Hello World!"

    ## Nim has first-class function support
    ## (functions that can be an argument to another function)
    ## 
    ## Here is an example of a chain of funtions that take anonymous
    ## functions (denoted by operator `=>`).
    ## 
    ## In this example we create a sequence of integers from 1 to 10,
    ## double each member of the sequence by 2 and then filter out
    ## all members that are not divisible by 6 without a reminder.
    var a = toSeq(1..10)
        .map(x => x * 2)
        .filter(x => x mod 6 == 0)

    assert a == @[6, 12, 18]

    ## Passing mutable argument to a function
    a.double()
    assert a == @[12, 24, 36]

demo()
