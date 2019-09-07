## Nim has many niceties of a modern programming language.
## One of them is a plethora of functions available in several
## key modules, such as algorithm, sugar, sequtils, strutils, etc.
## 
## This little program takes an unsorted sequence of tuples
## representing 2018 happiness scores of various countries
## sorts them decrementally and shows the resulting ranks.

import algorithm, sugar, sequtils

type
    Country = tuple
        ## Tuples with named fields come in handy at times
        name: string
        index: float

proc main() =
    var countries: seq[Country] = @[
        ("Sweden", 7.343),
        ("Norway", 7.554),
        ("New Zealand", 7.307),
        ("Denmark", 7.600),
        ("Netherlands", 7.488),
        ("Canada", 7.278),
        ("Iceland", 7.494),
        ("Finland", 7.769),
        ("Switzerland", 7.480)
    ]

    ## `sugar` module provides shortucts for anonymous
    ## functions among other things
    countries.sort((x, y: Country) => (if x.index > y.index: -1 else: 1))

    ## This is an example of making imperative code
    ## shorter and arguably more readable with iterators.
    ## Also notice, how we are using a named field of the `Country` tuple.
    echo "World's happiest countries:"
    for rank, country in countries.pairs():
        echo rank + 1, " - ", country.name

    ## Here is a more conventional imperative way of doing the same
    var rank = 1
    for i in 0 .. len(countries) - 1:
        echo rank, " - ", countries[i].name
        rank += 1

main()
