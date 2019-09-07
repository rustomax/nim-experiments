import sugerror, options, strutils

proc inputSameLine*(prompt: string): string =
    ## Nim doesn't have a built-in function to print out a text prompt
    ## and then collect user input on the same line, so we'll roll out our own.
    stdout.write(prompt)
    stdout.flushFile()
    stdin.readLine()

proc strToInt*(s: string): Option[int] =
    ## Instead of raising an exception, this function will return
    ## a none(int) optional value, if conversion of the string `s`
    ## to `int` fails, and some(value) otherwise.
    parseInt(s).toOption()
