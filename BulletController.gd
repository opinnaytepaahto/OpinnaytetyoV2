
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

const SPEED = 30

var velocity = Vector2()

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	velocity.x += SPEED * delta
	
	move(velocity)