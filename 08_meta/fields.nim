import macros, typeinfo
type
  Person = object
    name: string
    age: int
static:
  for sym in getType(Person)[2]:
    echo(sym)
  
    