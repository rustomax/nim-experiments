import stacks, unicode

let a = "Привет мир"
var s = Stack[Rune]()

for letter in a.runes:
    s.push(letter)

var b: string
while not s.empty:
    b.add(s.pop)

echo b
