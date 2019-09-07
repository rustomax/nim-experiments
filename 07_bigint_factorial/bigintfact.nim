## Factorial function for BigInts
##
## Compile: `nim c -d:release bigintfact.nim`
##
## Usage: `bigintfact <number>`

import strutils, bigints, parseopt
import "input"

type
    ArgumentException* = object of Exception
    ## User-defined exception

proc frec*(n: BigInt): BigInt =
    ## Calculates factorial for `BigInt` arguments using recursion.
    ## Factorial only applies to positive numbers.
    ## This function will overflow the stack on big numbers.
    if n < 0:
        raise(newException(ArgumentException, "Invalid argument"))
    if n == 0.initBigInt:
        return 1.initBigInt
    else:
        return n * frec(n - 1.initBigInt)

proc fiter*(n: BigInt): BigInt =
    ## Calculates factorial for `BigInt` arguments using iteration.
    ## Factorial only applies to positive numbers.
    ## This function will be much more resistant to overflow on big numbers.
    ## Because the memory is barely used
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
