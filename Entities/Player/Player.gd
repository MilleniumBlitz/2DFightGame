extends KinematicBody2D

signal health_updated()

const crouch_colision_size = Vector2(10,11)
const crouch_colision_position = Vector2(0,7)

const SPRITE_IDLE = "Idle"
const SPRITE_CROUCH = "Crouch"
const SPRITE_JUMP = "Jump"
const SPRITE_FALL = "Fall"
const SPRTIE_RUN = "Run"

onready var anim_player = $Sprite

var is_crouched = false

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 10
const JUMP_HEIGHT = -250
const ACCELERATION = 130
const MAX_SPEED = 170

onready var max_health = 100 
onready var health = max_health setget _set_health

var object_to_use = null

func _ready():
	connect("health_updated", $HealthBar, "_set_value")

func _physics_process(delta):
	$StateMachine._state_logic(delta)

func _handle_move_input():
	
	var move_direction = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
	if move_direction != 0:
		
		#Inverse the position of the arrow point
		if (sign($ArrowPoint.position.x) == 1 and sign(move_direction) == -1) or (sign($ArrowPoint.position.x) == -1 and sign(move_direction) == 1):
			$ArrowPoint.position *= -1
			
		$Sprite.flip_h = move_direction < 0
		
	motion.x = lerp(motion.x, ACCELERATION * move_direction, _get_h_weight())
	
	is_crouched = Input.is_action_pressed("ui_down")

func _apply_gravity(delta):
		motion.y += GRAVITY

func _apply_movement():
	motion = move_and_slide(motion, UP)

func _get_h_weight():
	return 0.2 if _check_is_grounded() else 0.1
	
func hit(damage):
	_set_health(health - damage)

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()

func kill():
#	$Sprite.tint
	pass

func _check_is_grounded():
	return is_on_floor()

func on_object_in_range(object):
	object_to_use = object
	
func on_object_out_range():
	object_to_use = null