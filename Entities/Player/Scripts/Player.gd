extends Character

class_name Player

export(float) var fire_rate = 0.4

var can_move = true

var aim_arrow_visible  = false setget set_aim_arrow_visible
var local_shooting_position setget set_local_shooting_position, get_local_shooting_position

# const crouch_colision_size = Vector2(10,11)
# const crouch_colision_position = Vector2(0,7)
onready var sprite = $Sprite
onready var anim_player = $Sprite

var is_crouched = false

var experience = 0 setget _set_experience
# var level = 1

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 2000
const JUMP_HEIGHT = -600
const ACCELERATION = 7000
const SPEED = 170

func _set_experience(value):
	experience = value
	$Label.text = str(experience)

var object_to_use = null

func get_facing_direction():
	return Vector2.LEFT if $Sprite.flip_h else Vector2.RIGHT

func _apply_gravity(delta):
	motion.y += GRAVITY * delta

func set_local_shooting_position(value):
	if (value.x == 0 and value.y == 0):	
		if get_facing_direction() == Vector2.LEFT:
			value.x = -20
		else:
			value.x = 20
	$ArrowPoint.position = value
	$ArrowPoint.rotation = value.angle()

func get_local_shooting_position():
	return $ArrowPoint.position

func move_toto(position):
	$Sprite2.position = position

func get_global_shooting_position():
	return $ArrowPoint.global_position

func set_aim_arrow_visible(value):
	aim_arrow_visible = value
	$ArrowPoint.visible = value
	

func _kill():
	$Sprite.modulate = Color(255,1,1)
	pass

func toggle_inventory():
	$Intenvory.set_visible(!$Intenvory.is_visible())

func _check_is_grounded():

	#Fonctionne
	return is_on_floor()

	#Ne fonctionne pas !
	for raycast in $Raycasts.get_children():
		if raycast.is_colliding():
			print(raycast.get_collider())
			return true
	return false

func on_object_in_range(object):
	object_to_use = object
	
func on_object_out_range():
	object_to_use = null
