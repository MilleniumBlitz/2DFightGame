extends Control

var cautious_zone_color = Color(255,255,0)
var danger_zone_color = Color(255,0,0)

onready var health_bar = $HealthBar

export(float, 0, 1, 0.1) var cautious_zone = 0.6
export(float, 0, 1, 0.1) var danger_zone = 0.2

func _set_value(health):
	
	if health < cautious_zone * 100:
		health_bar.tint_progress = cautious_zone_color
		
	if health < danger_zone * 100:
		health_bar.tint_progress = danger_zone_color
	
	health_bar.value = health