extends Area2D

class_name Bullet

export var speed = 200
var direction setget set_direction

func set_direction(value):
	direction = value

func _process(delta):
	position += direction * speed * delta
