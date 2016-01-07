
extends KinematicBody2D

# member variables here, example:
# var a=2
# var b="textvar"

# Movement variables #
const GRAVITY = 800.0
const FRICTION = 50.0

const WALK_SPEED = 10.0
const JUMP_HEIGHT = 400.0

var jumping = false
var jump_timer = 0.2

var velocity = Vector2()
# ------------------ #

var screen_size
var player_size

var player_pos

func _ready():
	screen_size = get_viewport_rect().size
	player_size = get_node("Image").get_texture().get_size()
	
	var detector = get_node("ButtonDetector")
	
	set_fixed_process(true)
	set_process(true)
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
		if (velocity.x > 20):
			velocity.x -= FRICTION
		elif (velocity.x < -20):
			velocity.x += FRICTION
		else:
			velocity.x = 0
	
	if (Input.is_action_pressed("player_jump") and not jumping):
		velocity.y = -JUMP_HEIGHT
		jump_timer = 1
		jumping = true
	
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

func _process(delta):
	if (jump_timer > 0):
		jump_timer -= delta
	else:
		jumping = false
	print(jump_timer)