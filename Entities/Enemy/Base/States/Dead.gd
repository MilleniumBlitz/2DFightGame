extends State

func _enter():
	owner.sprite.set_modulate(Color(1, 1, 255))
	owner.collision_shape.set_deferred("disabled", true)
	
	
	#LOOT
	var sword_instance = GLOBAL.get_random_sword()
	sword_instance.position = owner.position
	get_tree().get_root().add_child(sword_instance)
	
