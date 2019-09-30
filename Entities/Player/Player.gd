extends KinematicBody2D

signal health_updated()

const SPRITE_IDLE = "Idle"
const SPRITE_CROUCH = "Crouch"
const SPRITE_JUMP = "Jump"
const SPRTIE_FALL = "Fall"
const SPRTIE_RUN = "Run"

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 15
const JUMP_HEIGHT = -350
const ACCELERATION = 600
const MAX_SPEED = 170

onready var max_health = 100 
onready var health = max_health setget _set_health
	
func hit(damage):
	_set_health(health - damage)
	
func _ready():
	connect("health_updated", $HealthBar, "_set_value")

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
		
func kill():
	$Sprite.tint
	pass
	
func _physics_process(delta):
	
	#TEST HEALTHBAR
	
	
	
	#MOVEMENTS
	
	var friction = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		if sign($ArrowPoint.position.x) == -1:
			$ArrowPoint.position.x *= -1
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play(SPRTIE_RUN)
	elif Input.is_action_pressed("ui_left"):
		if sign($ArrowPoint.position.x) == 1:
			$ArrowPoint.position.x *= -1
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play(SPRTIE_RUN)
	else:
		if Input.is_action_pressed("ui_down"):
			$Sprite.play(SPRITE_CROUCH)
		else:
			$Sprite.play(SPRITE_IDLE)
		friction = true

	
	#SHOOT
	
	if Input.is_action_just_pressed("shoot"):
		
		var arrow_instance = GLOBAL._get_new_arrow($ArrowPoint.global_position, 5)
		arrow_instance.direction = sign($ArrowPoint.position.x)
		get_tree().get_root().add_child(arrow_instance)
		
		
	#INVENTORY
		
	if Input.is_action_just_pressed("toggle_inventory"):
		$Intenvory._toggle()
		
	#MOVEMENTS
		
	if is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.3) * delta
	else:
		
		if Input.is_action_pressed("ui_down"):
			motion.y += 10
		
		if motion.y < 0:
			$Sprite.play(SPRITE_JUMP)
		else:
			$Sprite.play(SPRTIE_FALL)
		if friction:
			motion.x = lerp(motion.x, 0, 0.05) * delta
			
	motion = move_and_slide(motion, UP)
