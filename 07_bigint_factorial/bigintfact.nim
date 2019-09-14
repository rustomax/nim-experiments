## Factorial function for BigInts
##
## Compile:
##
## ```sh
##    nimble install bigints    
##    nim c -d:release bigintfact.nim
## ```
##
## Usage: `bigintfact <number>`


import strutils, bigints, parseopt

type
    ArgumentException* = object of Exception
    ## User-defined exception

proc frec*(n: BigInt): BigInt =
    ## Calculates factorial for `BigInt` arguments using recursion.
    ## Factorial only applies to positive numbers.
    ## This function will overflow the stack on big numbers because
    ## deep recursion will cause high memory usage.
    if n < 0:
        raise(newException(ArgumentException, "Invalid argument"))
    if n == 0.initBigInt:
        return 1.initBigInt
    else:
        return n * frec(n - 1.initBigInt)

proc fiter*(n: BigInt): BigInt =
    ## Calculates factorial for `BigInt` arguments using iteration.
    ## Factorial only applies to positive numbers.
    ## This function is more resistant to overflow on big numbers,
    ## because memory usage is constent and low.
    if n < 0:
        raise(newException(ArgumentException, "Invalid argument"))
    result = 1.initBigInt
    for j in 1.initBigInt..n:
      result *= j

proc demo*() =
    ## Demonstrates the use of BigInt factorial function.

    var opt = initOptParser()
    var num, fr, fi: BigInt

    try:
        opt.next()
        num = initBigInt(opt.key)
        fr = frec(num)
        fi = fiter(num)
    except:
        echo "ERROR: ", getCurrentExceptionMsg()
        echo "Usage: bigintfact <number>"
        quit(127)

    assert fr == fi
    echo fr
    echo fi

demo()
