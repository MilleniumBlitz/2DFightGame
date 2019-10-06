extends Character

class_name BaseEnemy

tool

func _kill():
	$CollisionShape2D.set_deferred("disabled", true)
#	$CollisionShape2D.disabled = true
	print($CollisionShape2D.disabled)
	$Sprite.set_modulate(Color(1, 1, 255))
	pass
