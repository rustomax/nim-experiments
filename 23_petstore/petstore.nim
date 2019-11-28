import sugar, strformat, options, strutils

type
    Kind* {.pure.} = enum
        Dog
        Cat
        Fish

    Size* {.pure.} = enum
        Small
        Medium
        Large

    Pet* = ref object of RootObj
        id*: int
        kind*: Kind
        breed*: string
        age*: int
        size*: Size
        description*: string

    Store* = seq[Pet]

proc `$`*(this: Pet): string =
    fmt"""
Pet
  id: {this.id}
  kind: {this.kind}
  breed: {this.breed}
  age: {this.age}
  size: {this.size}
  description: {this.description}
"""

proc getAll*(this: Store, function: proc(x: Pet): bool {.closure.}): Store =
    result = @[]
    for pet in this:
        if function(pet):
            result.add pet

proc getOne*(this: Store, function: proc(x: Pet): bool {.closure.}): Option[Pet] =
    for val in this:
        if function(val):
            return some(val)

proc updateRecord*(this: var Store, pet: Pet) =
    for idx, val in this.pairs():
        if pet.id == val.id:
            this[idx] = pet
            return

proc `$`*(this: Store): string =
    for pet in this:
        result &= $pet

converter toDog(this: Pet): Pet =
    Pet(id: this.id,
        kind: Kind.Dog,
        breed: this.breed,
        age: this.age,
        size: this.size,
        description: this.description)

proc main() =
    var store: Store

    store.add(Pet(
        id: 101,
        kind: Kind.Dog,
        breed: "German Shepperd",
        age: 3,
        size: Size.Large,
        description: "Large, agile, muscular dog of noble character and high intelligence.")
    )

    store.add(Pet(
        id: 102,
        kind: Kind.Dog,
        breed: "American Staffordshire Terrier",
        age: 1,
        size: Size.Medium,
        description: "Smart, confident, good-natured companion.")
    )

    store.add(Pet(
        id: 103,
        kind: Kind.Cat,
        breed: "Bombay",
        age: 1,
        size: Size.Medium,
        description: "Easy-going, yet energetic cat.")
    )

    # empty store is returned when no items satisfying provided criteria is found
    assert store.getOne(x => x.id == 200).isNone()

    echo "=== Pet with ID 101 ==="
    echo store.getOne(x => x.id == 101).get()

    echo "=== Cats only ==="
    echo store.getAll(x => x.kind == Kind.Cat)

    echo "=== Young pets ==="
    echo store.getAll(x => x.age < 2)

    let breed = "Bombay"
    echo "=== Changing " & breed & " cat to a dog ==="

    let cat = store.getOne(x => x.breed == breed)

    if not cat.isNone:
        var val = cat.get()
        val.description = cat.get().description.replace("cat", "dog")
        store.updateRecord(val.toDog)
        echo store.getOne(x => x.breed == breed).get()
    else:
        echo breed & " is not in stock"

main()