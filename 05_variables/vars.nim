## This is a module talking about variables.

import unicode, random, sequtils
import input

proc rollDice*(): int =
    ## Imitates a roll of a dice by returning a random number between 1 and 6.
    ## Output of this function is not deterministic, so it has side effects.
    result = rand(1..6)

proc reverseUnicode*(s: string): string {.noSideEffect.} =
    ## Correctly reverses a Unicode string.
    ## Internally the string first gets converted into a sequence of Unicode runes,
    ## iterated on in reverse, and then converted back into a string.
    ## There are no side effects in this function: `{. noSideEffect .}` pragma
    let runes = toRunes(s)
    var rev = newSeq[Rune]()

    for i in countdown(runes.high, 0):
        rev.add(runes[i])

    $rev

proc demo_vars*() =
    ## Demonstrates concepts related to variables in Nim.

    var x, y: int ## `x` and `y` store integers.

    ## When variables are created, they will get default values (0 for Integers).
    assert x == 0
    assert y == 0

    y += 5 ## var defines mutable variables.

    ## `let` defines an immutable variable.
    ##
    let z = 4.5

    ## Variable type can be inferred in many cases.
    let i = 10_000
    var s = "a string"

    ## The following will fail to compile with `Error: 'z' cannot be assigned to`
    ## z = z * 2.0

    ## Constants are defined with the `const` keyword.
    const BLUE = 0x0000FF

    ## Constants can be assinged expression results.
    const hours = 12 * 2
    assert hours == 24

    ## Difference between constants and let variables:
    ## while let variables can be assigned value at runtime,
    ## constants must be fully evaluated at compile time:

    let age = inputSameLine("What is your age? ") # this works
    echo("You are ", age, " years old")
    ## const input = readLine(stdin) # Error: cannot evaluate at compile time: stdin

    ## multiple assignments
    var m1, m2, m3 = 42
    assert m1 == 42
    assert m2 == 42
    assert m3 == 42

    ## You have to make sure there are no side effects
    ## when using functions on the right side of the multiple assignments,
    ## so getReversedAlphabet() is marked as {. noSideEffect .}
    let russian_alphabet = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
    let alpha1, alpha2 = reverseUnicode(russian_alphabet)
    assert alpha1 == alpha2
    echo alpha1

    ## Unless you *want* them to be different!
    randomize()
    let r1, r2, r3 = rollDice()
    ## Chances are these numbers are different:
    echo("Random numbers: ", r1, " ", r2, " ", r3)

demo_vars()
