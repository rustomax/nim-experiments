## Demonstrates control flow constructs in Nim

type Seasons = enum
    winter,
    spring,
    summer,
    fall

proc main() =
    var season = winter

    ## Conventional if/elif/else statement
    if season == winter:
        echo "It's cold"
    elif season == spring:
        echo "Flowers are in bloom"
    elif season == summer:
        echo "It's hot"
    elif season == fall:
        echo "The colors are beautiful"
    else:
        echo "This season doesn't exist"

    ## Same thing, but with a case statement
    season = summer
    case season
        of winter: echo "It's cold"
        of spring: echo "Flowers are in bloom"
        of summer: echo "It's hot"
        of fall: echo "The colors are beautiful"
    ## Try commenting out the last `of` choice above
    ## This won't compile - the case is an exhaustive statement
    ## Error: not all cases are covered; missing: {fall}

    ## Case is an expression, so you can use it in an assignment.
    ## Also notice that we used `else` to capture the last choice.
    season = fall
    let weather = case season
        of winter: "It's cold"
        of spring: "Flowers are in bloom"
        of summer: "It's hot"
        else: "The colors are beautiful"
    assert weather == "The colors are beautiful"

    ## Traditional while loop
    var s: seq[int]
    var i = 100
    while i >= 0:
        s.add(i)
        i -= 10
    assert s == @[100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0]

    ## For loop will iterate over anything iterable
    ## Produces the same result as the above while loop
    s = @[]
    for i in countdown(100, 0, 10):
        s.add(i)
    assert s == @[100, 90, 80, 70, 60, 50, 40, 30, 20, 10, 0]

    ## for loop will iterate over a sequence or an array
    for elem in s:
        discard

    ## You can yield mutable values from an interator.
    ## By conventions mutable iterator methods' names start with the letter "m"
    var q = @[1, 2, 3, 4, 5]
    for elem in q.mitems():
        elem *= 2
    assert q == @[2, 4, 6, 8, 10]

    ## If you need index as well as value, you can use `pairs` iterator
    ## The index starts with 0
    let days = ["Sunday", "Monday", "Tuesday", "Wednessday", "Thursday",
            "Friday", "Saturday"]
    for num, day in days.pairs():
        echo num, " - ", day
    ## Output:
    ##   0 - Sunday
    ##   1 - Monday
    ##   ...

    ## You can iterate over a simple range
    for i in 1..10:
        discard

    ## 0-based index counting has a couple of shortcuts "..<" and "..^"
    let name = "Jane Doe"
    for i in 0..<name.len():
        discard

main()
