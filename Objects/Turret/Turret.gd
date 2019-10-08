extends Node2D

tool

enum ShootingDirection {LEFT = -1, RIGHT = 1}
export (ShootingDirection) var shooting_direction  = ShootingDirection.LEFT setget _set_shooting_direction

export(float) var fire_rate = 0.5
export(int) var damage = 5
export(bool) var enabled = true

onready var shooting_point = $Turret/ShootingPoint
var arrow = preload("res://Entities/Arrow/Arrow.tscn")
onready var shoot_cooldown = Cooldown.new(fire_rate)

func _process(delta):
	if !Engine.editor_hint:
		shoot_cooldown.tick(delta)
		if shoot_cooldown.is_ready():
			_shoot_arrow()

func _shoot_arrow():
	var arrow_instance = GLOBAL._get_new_arrow(shooting_point.position, damage)
	arrow_instance.direction = sign(shooting_direction)
	add_child(arrow_instance)
	
func _set_shooting_direction(value):
	shooting_direction = value
	if (sign($Turret/ShootingPoint.position.x) == 1 and sign(shooting_direction) == -1) or (sign($Turret/ShootingPoint.position.x) == -1 and sign(shooting_direction) == 1):
			$Turret/ShootingPoint.position *= -1
