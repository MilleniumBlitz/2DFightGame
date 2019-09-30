extends Node2D

export(float) var fire_rate = 0.5
export(int) var damage = 5
export(bool) var enabled = true

onready var shooting_point = $Turret/ShootingPoint
var arrow = preload("res://Entities/Arrow/Arrow.tscn")

func _ready():
	$ShootingTimer.wait_time = fire_rate
	pass

func _on_ShootingTimer_timeout():
	if enabled:
		_shoot_arrow()
	pass
	
func _shoot_arrow():
	var arrow_instance = GLOBAL._get_new_arrow(shooting_point.global_position, damage)	
	get_tree().get_root().add_child(arrow_instance)
	
	pass
