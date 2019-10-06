extends Character

class_name Player

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
const GRAVITY = 400
const JUMP_HEIGHT = -230
const ACCELERATION = 100
const MAX_SPEED = 170

var object_to_use = null

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

func get_facing_direction() -> Vector2:
    return Vector2.LEFT if $Sprite.flip_h else Vector2.RIGHT

func _apply_gravity(delta):
	motion.y += GRAVITY * delta

func _apply_movement():
	if !is_crouched:
		motion = move_and_slide(motion, UP)

func _get_h_weight():
	return 0.8 if _check_is_grounded() else 0.8

func get_shooting_position():
	return $ArrowPoint.global_position

func _kill():
	$Sprite.modulate = Color(255,1,1)
	pass

func toggle_inventory():
	$Intenvory.set_visible(!$Intenvory.is_visible())

func _check_is_grounded():
	for raycast in $Raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func on_object_in_range(object):
	object_to_use = object
	
func on_object_out_range():
	object_to_use = null