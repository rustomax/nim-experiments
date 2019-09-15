import stacks

let a = "Hello, World!"
var s = Stack[char]()

for letter in a:
    s.push(letter)

var b: string
while not s.empty:
    b.add(s.pop)

assert b == "!dlroW ,olleH"
