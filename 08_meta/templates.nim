template `!~` (a, b: untyped): untyped =
    ## totally superflous logical binary not operator
    not (a == b)

template `==>` (a: untyped): untyped =
    ## totally superflous logical unary not operator
    not (a)
    
template repeat(statements: untyped) =
    while true:
        statements

template times(count: int, statements: untyped) =
    for i in 0 .. count - 1:
        statements

template hygiene(varName: untyped) =
    var varName = 42
    var notInjected = 128
    var injected {.inject.} = notInjected + 2


proc main() =

    assert(5 !~ 6) # the compiler rewrites that to: assert(not (5 == 6))
    assert(==> false) # the compiler rewrites that to: assert(not (false))

    var a = 1
    repeat:
        echo("Hello Templates ", a)
        a += 1
        if a > 5:
            break

    3.times:
        echo("More templates")

    hygiene(injectedImplicitly)
    assert injectedImplicitly == 42
    assert injected == 130
    # assert notInjected == 128
    # Error: undeclared identifier: 'notInjected' == template's hygiene at work

main()