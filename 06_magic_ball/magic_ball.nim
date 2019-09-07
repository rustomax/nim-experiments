import random

## `responses` is a global constant.
## It is accessible by all procedures within the module.
const responses = @[
    "It is certain.", "It is decidedly so.", "Without a doubt.",
    "Yes - definitely.", "You may rely on it.", "As I see it, yes.",
    "Most likely.", "Outlook good.", "Yes.", "Signs point to yes.",
    "Reply hazy, try again.", "Ask again later.", "Better not tell you now.",
    "Cannot predict now.", "Concentrate and ask again.",
    "Don't count on it.", "My reply is no.", "My sources say no.",
    "Outlook not so good.", "Very doubtful."
]

proc getResponse(): string =
    responses[rand 0..<responses.len()]

proc main() =

    randomize()

    var question: string
    while true:
        stdout.write("Ask your question (quit to exit): ")
        question = stdin.readLine()
        if question == "quit":
            echo "Goodbye"
            break
        echo getResponse()

main()
