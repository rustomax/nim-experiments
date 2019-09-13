# Demonstrates writing and reading JSON to/from files
import json

type Sex = enum
    male
    female

type Person = object
    name: string
    sex: Sex
    age: int

var people_orig, people_read: seq[Person]

people_orig = @[
    Person(name: "John Doe", sex: male, age: 42),
    Person(name: "Jane Doe", sex: female, age: 39),
    Person(name: "Max Blow", sex: male, age: 21),
    Person(name: "Julie Strange", sex: female, age: 60),
]

let file_name = "test_file.json"

block:
    # Open file for writing
    let f = open(file_name, fmWrite)

    # Serialize json into a string
    # Write JSON to the file
    f.write (%*people_orig).pretty()

    # Close the file
    f.close

block:
    # Open file for reading
    let f = open(file_name, fmRead)

    # Read full contents of the file into a string
    # Parse the string into JSON
    # Unmarshall json into a type
    people_read = f.readAll().parseJson().to(seq[Person])

    # Close the file
    f.close

assert people_read == people_orig
