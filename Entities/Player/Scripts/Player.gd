extends Character

class_name Player

const UP = Vector2(0, -1)
const GRAVITY = 2300
const JUMP_HEIGHT = -600
const ACCELERATION = 8
const AIR_ACCELERATION = 6
const DECELERATION = 2
const MAX_SPEED = 300

export(float) var fire_rate = 0.4
export(float) var attack_rate = 1

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer

var aim_arrow_visible  = false setget set_aim_arrow_visible
var local_shooting_position setget set_local_shooting_position, get_local_shooting_position

onready var shoot_cooldown = Cooldown.new(fire_rate)
onready var attack_cooldown = Cooldown.new(attack_rate)

var motion = Vector2()
var can_move = true
var is_crouched = false
var double_jumped = false

var current_item
var items = []
var max_item_count = 9

func _ready():
	
	current_item = GLOBAL.get_random_sword()
	items.append(current_item)
func _process(delta):
	shoot_cooldown.tick(delta)
	attack_cooldown.tick(delta)
	if Input.is_action_pressed("hold_bow"):
		
		if shoot_cooldown.is_ready():
			var arrow_instance = GLOBAL._get_new_arrow(get_global_shooting_position(), 5)
			arrow_instance.direction = get_local_shooting_position().normalized()
			arrow_instance.initial_speed = motion.x
			# $AudioStreamPlayer2D.play()

			# get_tree().get_root().add_child(arrow_instance)


func get_current_item():
	if current_item:
		return current_item.item_name
	return ""

func is_acttack_ready():
	return attack_cooldown.is_ready()

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

	#ECRAN DE MORT
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

func on_item_in_range(item):
	pick(item)

func pick(item):
	if items.size() < max_item_count:
		item.picked = true
		current_item = item
		items.append(item)
		
func _on_Area2D_body_entered(body):
	
	#ATTAQUE EPEE
	if body.has_method("_hit"):
		if current_item:
			body._hit(current_item.damage)
		else:
			body._hit(50)
