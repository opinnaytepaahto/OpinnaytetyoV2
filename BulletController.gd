
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

const SPEED = 600

var remove_timer = 2

var velocity = Vector2()

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	remove_timer -= delta
	
	if (remove_timer <= 0):
		self.queue_free()
		
	if (get_parent().left):
		velocity.x -= SPEED * delta

	velocity.x = SPEED * delta
	
	move(velocity)