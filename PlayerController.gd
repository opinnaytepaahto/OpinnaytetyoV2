
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

# Movement variables #
const GRAVITY = 200.0
const FRICTION = 20.0

const WALK_SPEED = 20.0
const JUMP_HEIGHT = 200.0

var jumping = false
var jump_timer = 2

var velocity = Vector2()
# ------------------ #

var screen_size
var player_size

var player_pos

func _ready():
	screen_size = get_viewport_rect().size
	player_size = get_node("Image").get_texture().get_size()
	
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	# Gravity
	velocity.y += delta * GRAVITY
	
	# Movement with keys
	if (Input.is_action_pressed("player_right")):
		velocity.x += WALK_SPEED
		get_node("Image").set_flip_v(false)
		get_node("Image").set_flip_h(false)
	elif (Input.is_action_pressed("player_left")):
		velocity.x -= WALK_SPEED
		get_node("Image").set_flip_v(true)
		get_node("Image").set_flip_h(true)
	else:
		if (velocity.x > 0):
			velocity.x -= FRICTION
		elif (velocity.x < 0):
			velocity.x += FRICTION
	
	if (Input.is_action_pressed("player_jump") and not jumping):
		velocity.y = -JUMP_HEIGHT
		jump_timer = 2
		jumping = true
		
	if (jump_timer > 0):
		jump_timer -= delta
	else:
		jumping = false
	
	# Move according to our velocity
	var motion = velocity * delta
	motion = move(motion)
	
	# Slide if you are colliding (don't get stuck when you hit something)
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
	pass