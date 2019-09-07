import strutils, bigints, parseopt
import input

proc fib(n: int): int =
    if n <= 2:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

proc main() =
    var opt = initOptParser()
    var num, fib: int

    try:
        opt.next()
        num = parseInt(opt.key)
        fib = fib(num)
    except:
        echo "ERROR: ", getCurrentExceptionMsg()
        echo "Usage: fib <number>"
        quit(127)

    echo "Fibonacci number of ", num, " is ", fib

main()