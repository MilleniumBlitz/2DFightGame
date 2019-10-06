extends Control

tool
class_name HealthBar
var base_color = Color(0,255,0)
var cautious_zone_color = Color(255,255,0)
var danger_zone_color = Color(255,0,0)

onready var health_bar = $HealthBar

var health = 100 setget _set_value
export(float, 0, 1, 0.1) var cautious_zone = 0.6
export(float, 0, 1, 0.1) var danger_zone = 0.2


func _ready():
	_set_value(health)

func _set_max_health(value):
	print("oui")
	$HealthBar.max_value = value
	pass

func _set_value(value):
	health = value
	
	if health > cautious_zone:
		$HealthBar.tint_progress = base_color
	
	if health < cautious_zone * $HealthBar.max_value:
		$HealthBar.tint_progress = cautious_zone_color
		
	if health < danger_zone * $HealthBar.max_value:
		$HealthBar.tint_progress = danger_zone_color
	$Label.text = str(health)
	$HealthBar.value = health