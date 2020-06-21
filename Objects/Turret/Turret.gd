extends Node2D

tool

enum ShootingDirection {LEFT = -1, RIGHT = 1}
export (ShootingDirection) var shooting_direction  = ShootingDirection.LEFT setget _set_shooting_direction

export(float) var fire_rate = 0.5
export(int) var damage = 5
export(bool) var enabled = true

onready var shooting_point = $Turret/ShootingPoint
onready var shoot_cooldown = Cooldown.new(fire_rate)

func _process(delta):
	if !Engine.editor_hint && enabled:
		shoot_cooldown.tick(delta)
		if shoot_cooldown.is_ready():
			_shoot_arrow()

func _shoot_arrow():
	pass
	#var arrow_instance = GLOBAL._get_new_arrow(shooting_point.get_global_position(), damage)
	#arrow_instance.direction = Vector2(shooting_direction, 0)
	
func _set_shooting_direction(value):
	shooting_direction = value
	if (sign($Turret/ShootingPoint.position.x) == 1 and sign(shooting_direction) == -1) or (sign($Turret/ShootingPoint.position.x) == -1 and sign(shooting_direction) == 1):
			$Turret/ShootingPoint.position *= -1
