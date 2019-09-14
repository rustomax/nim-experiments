import random, strutils
import input

proc main() =
    randomize()
    let secret = rand(1..100)
    echo "I am thinking of a number between 1 and 100"

    var attempts: int
    while true:
        var guess: int
        let input = inputSameLine("Your guess: ")
        try:
            guess = parseInt(input)
        except:
            echo "Incorrect value"
            continue

        attempts += 1
        
        if guess < secret:
            echo "Too low"
        if guess > secret:
            echo "Too high"
        if guess == secret:
            break

    echo "Correct! It took you ", attempts, " tries to find the answer."

main()