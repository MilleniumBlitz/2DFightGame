extends Area2D

class_name Bullet

export var speed = 800
var direction setget set_direction
var initial_speed = 0

func set_direction(value):
	
	direction = value

func _process(delta):
	global_position += Vector2(initial_speed * delta, 0) + direction * speed * delta
	initial_speed = 0
