# Demonstrates writing and reading JSON to/from files
import json

type Sex = enum
    male
    female
    tree

type Person = object
    name: string
    sex: Sex
    age: int

var avengers, avengers_from_file: seq[Person]

avengers = @[
    Person(name: "Teenage Groot", sex: tree, age: 4),
    Person(name: "Gamora", sex: female, age: 29),
    Person(name: "Iron Man", sex: male, age: 48),
    Person(name: "Vision", sex: male, age: 3),
    Person(name: "Spider-Man", sex: male, age: 18),
    Person(name: "Mantis", sex: female, age: 32),
    Person(name: "Star-Lord", sex: male, age: 38),
]

let file_name = "test_file.json"

block:
    # Open file for writing
    let f = open(file_name, fmWrite)

    # Serialize json into a string and prettify it
    # Write JSON to the file
    f.write (%*avengers).pretty()

    # Close the file
    f.close

block:
    # Open file for reading
    let f = open(file_name, fmRead)

    # Read full contents of the file into a string
    # Parse the string into JSON
    # Unmarshall json into a type
    avengers_from_file = f.readAll().parseJson().to(seq[Person])

    # Close the file
    f.close

assert avengers_from_file == avengers
