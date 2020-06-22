extends Character

class_name BaseEnemy

onready var sword = preload("res://Weapons/Sword/Sword.tscn")
signal health_updated(value)
signal max_health_updated(value)

export(int,0,100,5) var max_health = 100

onready var health = max_health

onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

func _is_dead():
	return health == 0

func _hit(damage):
	if !_is_dead():
		#Damage counter
		var damage_label_instance = damage_label.instance()
		damage_label_instance.text = "-" + str(damage)
		add_child(damage_label_instance)
		if health - damage > 0:
			_set_health(health - damage)
		else:
			_set_health(0)
	pass

func _set_health(value):
	health = value
	emit_signal("health_updated", health)
		

func _set_max_health(value):
	max_health = value
	emit_signal("max_health_updated", max_health)
