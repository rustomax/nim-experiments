## Using optionals to ensure correct input
import options
import input

var i: Option[int]

while true:
    i = inputSameLine("Please enter an int: ").strToInt()
    if i == none(int):
        echo "Incorrect input"
    else:
        break

echo "You entered: ", i.get()