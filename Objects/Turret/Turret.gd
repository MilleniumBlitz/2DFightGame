extends Node2D

export(float) var fire_rate = 0.5
export(int) var damage = 5
export(bool) var enabled = true

onready var shooting_point = $Turret/ShootingPoint
var arrow = preload("res://Entities/Arrow/Arrow.tscn")
onready var shoot_cooldown = Cooldown.new(fire_rate)
func _ready():

	$ShootingTimer.wait_time = fire_rate

func _process(delta):
	shoot_cooldown.tick(delta)
	if shoot_cooldown.is_ready():
		_shoot_arrow()

func _on_ShootingTimer_timeout():
	pass
#	if enabled:
#		_shoot_arrow()

func _shoot_arrow():
	var arrow_instance = GLOBAL._get_new_arrow(shooting_point.position, damage)	
	add_child(arrow_instance)
