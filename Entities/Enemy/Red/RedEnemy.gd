extends "res://Entities/Enemy/Base/BaseEnemy.gd"

func _ready():
	$MoveTween.interpolate_property(self, "position", get_position(), Vector2(0, 20), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$MoveTween.interpolate_property(self, "position", Vector2(0, 20), Vector2(0, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2)
	$MoveTween.start()

func _kill():
	._kill()
	print("tuer un red")