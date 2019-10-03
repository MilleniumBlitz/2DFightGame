extends Node2D

signal health_updated()

onready var max_health = 100 
onready var health = max_health setget _set_health

func _ready():
	var health_bar = get_parent().get_node("HealthBar")
	connect("health_updated", health_bar, "_set_value")

func hit(damage):
	_set_health(health - damage)
	
func kill():
	$Sprite.set_modulate(Color(255, 1, 1, 1))
	pass
		
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()