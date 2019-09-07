import strutils
import input

proc factorial(n: uint64): uint64 =
    if n == 0:
        return 1
    else:
        return n * factorial (n - 1)

proc main() =
    let input = inputSameLine("Enter a number: ")
    let num: uint64 = cast[uint64](parseInt(input))
    echo "Factorial of ", num, " = ", factorial(num)

main()
