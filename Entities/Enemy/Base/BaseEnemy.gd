extends Character

class_name BaseEnemy

onready var sword = preload("res://Weapons/Sword/Sword.tscn")
signal health_updated(value)
signal max_health_updated(value)

export(int,0,100,5) var max_health = 100

onready var health = max_health

func _is_dead():
	return health == 0

func _hit(damage):
	if !_is_dead():
		#Damage counter
		var damage_label_instance = damage_label.instance()
		damage_label_instance.text = "-" + str(damage)
		add_child(damage_label_instance)
		print("totosdsd")
		_set_health(health - damage)
	pass

func _kill():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite.set_modulate(Color(1, 1, 255))
	
	#LOOT
	var sword_instance = sword.instance()
	sword_instance.position = position
	get_tree().get_root().add_child(sword_instance)


func _set_health(value):
	health = value
	emit_signal("health_updated", health)
	if health == 0:
		_kill()
		

func _set_max_health(value):
	max_health = value
	emit_signal("max_health_updated", max_health)
