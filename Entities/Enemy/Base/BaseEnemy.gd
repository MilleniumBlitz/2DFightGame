extends Character

class_name BaseEnemy

export var experience = 10

tool

func _kill():
	GLOBAL.player.experience += experience
	$CollisionShape2D.set_deferred("disabled", true)
#	$CollisionShape2D.disabled = true
	print($CollisionShape2D.disabled)
	$Sprite.set_modulate(Color(1, 1, 255))
	pass
