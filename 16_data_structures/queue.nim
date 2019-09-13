# `Deques` module supersedes older `queues` module.
# The benefit of deque is that it implements a double-ended queue.
# The implementation uses Nim sequences under the hood.
import deques, math

proc doubleQueue[T: SomeNumber](q: var Deque[T]) =
  ## Multiply every member of a queue by 2 in-place.
  ## Uses mutable `mitems()` iterator.
  for v in q.mitems():
    v *= 2

proc toSeq[T](q: Deque[T]): seq[T] =
  ## Returns sequence containing all elements of the queue.
  ## Does not modify original queue.
  ## Uses immutable `items()` iterator.
  result = @[]
  for v in q.items():
    result.add(v)

# Create a new queue.
# Notice similarity to the sequence initializer:
# `var a = newSeq[int]()`
# You can resrve the queue capacity, but keep in mind that it must be a power of `2`
var a = initDeque[int](nextPowerOfTwo(10))

# Regardless of reserved capacity, the length of an empty queue is always `0`
assert a.len() == 0

# Any read access on an empty queue will result in an error at compile time
# or even worse - undefined behavior at runtime.
# Before reading from the queue, you should check whether it is empty.
doAssertRaises(IndexError, echo a[0])

for i in 1..10:
  a.addLast(i * 2)

# Documented way to check the contents of the queue
# is by converting it into a string
assert $a == "[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]"

# Queues in many ways behave like sequences. Some examples below:

# Assigning one queue to another. Notice type inference at work.
let b = a
assert a == b

# Passing queue to a function
a.doubleQueue()
assert $a == "[4, 8, 12, 16, 20, 24, 28, 32, 36, 40]"

# b.doubleQueue()
# As expected, the above won't compile. Error `type mismatch
#    ... for a 'var' type a variable needs to be passed, but 'b' is immutable`

# Of course, there is no problem passing an immutable queue to a function
# that expects an immutable argument
assert b.toSeq() == @[2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

# Range access is not implemented for queues. The following won't compile:
# echo a[0..3]
# But there are some nice "shortcuts" for peeking a specific element, ex.:
assert a[0] == a.peekFirst()
assert a[1] == 8
assert a[^1] == a.peekLast()
assert a[^2] == 36

# Let's go back to queue-specific methods.

# `peek` methods show the value of first or last elements
# of the queue without dequeueing them.
assert a.peekFirst == 4
assert a.peekLast == 40
assert len(a) == 10

# `pop` methods dequeue the elements.
assert a.popFirst == 4
assert a.popLast == 40
assert len(a) == 8

# `add` methods queue elements to the beginning or the end of the queue.
a.addFirst(3)
a.addFirst(2)
a.addFirst(1)
assert $a == "[1, 2, 3, 8, 12, 16, 20, 24, 28, 32, 36]"

# `shrink(x, y)` removes `x` first and `y` last elements from the queue.
# Since the method doesn't return anything, the elements are not dequeued.
# They are effectively "lost".
a.shrink(1, 2)
assert $a == "[2, 3, 8, 12, 16, 20, 24, 28]"

# `clear` empties the queue
a.clear()
assert a.len() == 0