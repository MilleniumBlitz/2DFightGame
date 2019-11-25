extends KinematicBody2D

class_name Character

signal health_updated(value)
signal max_health_updated(value)

export(int,0,100,5) var max_health = 100

onready var health = max_health

var damage_label = preload("res://UI/DamageLabel/DamageLabel.tscn")

func _is_dead():
	return health == 0

func _hit(body, damage):
	if !_is_dead():
		#Damage counter
		var damage_label_instance = damage_label.instance()
		damage_label_instance.text = "-" + str(damage)
		add_child(damage_label_instance)
		
		_set_health(health - damage)
	pass
	
func _kill():
	pass
	
func _set_health(value):
	health = value
	emit_signal("health_updated", health)
	if health == 0:
		_kill()
		

func _set_max_health(value):
	max_health = value
	emit_signal("max_health_updated", max_health)