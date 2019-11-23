# Original code at https://github.com/oprypin/nim-csfml/blob/master/examples/snakes.nim
# Modified for single-player, added sound effects, several bugs fixed

import math, random, sequtils
import csfml, csfml/ext, csfml/audio, os

var window = new_RenderWindow(
    video_mode(800, 800), "Snake!",
    WindowStyle.Default, context_settings(32, antialiasing=8)
)
window.framerate_limit = 10

let
    Left = vec2(-1, 0)
    Up = vec2(0, -1)
    Right = vec2(1, 0)
    Down = vec2(0, 1)

# Load sound assets
let biteSoundBuffer = newSoundBuffer("resources/bite.wav")
let biteSound = newSound(biteSoundBuffer)
let gameoverSoundBuffer = newSoundBuffer("resources/gameover.wav")
let gameoverSound = newSound(gameoverSoundBuffer)

# Load the text font
var font = newFont("resources/sansation.ttf")

# Initialize the Game Over message
var gameoverMessage = newText("Game Over!", font, 40)
gameoverMessage.position = vec2(300, 300)
gameoverMessage.color = White

randomize()

proc random_color(): Color =
    color(rand(127)+128, rand(127)+128, rand(127)+128)

proc modulo[T](a, b: T): T =
    ## mod with wraparound: modulo(-7, 5)==3
    T(float(a) mod float(b))

type
    Food = object
        position: Vector2i
        color: Color
    
    Snake = ref object
        field: Field
        body: seq[Vector2i]
        color: Color
        direction: Vector2i
    
    Field = ref object
        size: Vector2i
        snakes: seq[Snake]
        foods: seq[Food]

proc init_Food(position: Vector2i, color: Color): Food =
    result.position = position
    result.color = color

proc draw[T](self: Food, target: T, states: RenderStates) =
    var circle = new_CircleShape(radius=0.9/2)
    circle.position = vec2(self.position)+vec2(0.05, 0.05)
    circle.fill_color = self.color
    target.draw circle, states
    circle.destroy()

proc new_Snake(field: Field, start: Vector2i, color: Color): Snake =
    new result
    result.field = field
    result.color = color
    result.direction = Up
    result.body = @[]
    for i in 0..2:
        result.body.add vec2(start.x, start.y+i)

proc step(self: Snake) =
    var head = self.body[0]+self.direction

    head.x = modulo(head.x, self.field.size.x)
    if head.x < 0:
        head.x += self.field.size.x

    head.y = modulo(head.y, self.field.size.y)
    if head.y < 0:
        head.y += self.field.size.y

    self.body.insert head
    discard self.body.pop()

proc turn(self: Snake, direction: Vector2i) =
    if self.body[1] != self.body[0]+direction:
        self.direction = direction

proc grow(self: Snake) =
    let tail = self.body[self.body.high]
    for i in 1..3:
        self.body.add tail

proc collide(self: Snake, food: Food): bool =
    self.body[0] == food.position

proc collide(self: Snake): bool =
    var first = true
    for part in self.body:
        if self.body[0] == part and not first:
            return true
        first = false
    return false

proc draw[T](self: Snake, target: T, states: RenderStates) =
    for i in self.body.low..self.body.high:
        let current = self.body[i]

        var segment = new_RectangleShape(vec2(0.9, 0.9))
        segment.position = vec2(current)+vec2(0.05, 0.05)
        segment.fill_color = self.color
        target.draw segment, states
        segment.destroy()

proc new_Field(size: Vector2i): Field =
    new result
    result.size = size
    result.foods = @[]

proc step(self: Field) =
    while self.foods.len < 3:
        let food = init_Food(
            vec2(rand(self.size.x), rand(self.size.y)), random_color()
        )

        # Don't allow new food on top of a snake
        if not collide(self.snakes[0], food):
            self.foods.add food

    self.snakes[0].step()

    self.foods = self.foods.filter do (food: Food) -> bool:
        if collide(self.snakes[0], food):
            biteSound.play()
            self.snakes[0].grow()
            return false
        return true
    
    if self.snakes[0].collide():
        echo "Game over!"
        window.clear Black
        window.draw gameoverMessage
        window.display()
        gameoverSound.play()
        sleep(2000)
        window.close()
        window.destroy()
        quit(0)

proc draw[T](self: Field, target: T, states: RenderStates) =
    target.draw self.snakes[0], states
    for food in self.foods:
        target.draw food, states

var field = new_Field(vec2(40, 40))

var snake1 = new_Snake(field, vec2(field.size.x div 2, field.size.y div 2), random_color())
field.snakes.add snake1

var transform = Identity
transform.scale vec2(20, 20)

let states = render_states(transform=transform)

while window.open:
    for event in window.events:
        if event.kind == EventType.Closed or
          (event.kind == EventType.KeyPressed and event.key.code == KeyCode.Escape):
            window.close()
        
        elif event.kind == EventType.KeyPressed:
            case event.key.code
                of KeyCode.Left: snake1.turn Left
                of KeyCode.Up: snake1.turn Up
                of KeyCode.Right: snake1.turn Right
                of KeyCode.Down: snake1.turn Down

                else: discard

    field.step()

    window.clear Black
    window.draw field, states
    
    window.display()

window.destroy()
