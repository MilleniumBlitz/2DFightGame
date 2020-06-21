extends "res://Entities/Enemy/Base/BaseEnemy.gd"

tool

export(Vector2) var direction = Vector2.RIGHT setget set_direction
export var distance = 50 setget set_distance
export var speed = 1

func _ready():
	if not Engine.editor_hint:
		var start_position = get_global_position()
		var final_position = distance * direction + start_position
		$MoveTween.interpolate_property(self, "position", start_position, final_position, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$MoveTween.interpolate_property(self, "position", final_position, start_position, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, speed)
		#$MoveTween.start()

func set_distance(value):
	distance = value
	update()

func set_direction(value):
	direction = value
	update()

func _draw():
	if Engine.editor_hint:
		draw_line(Vector2(0,0), distance * direction, Color(255, 0, 0), 5)

func _kill():
	._kill()
	print("tuer un red")