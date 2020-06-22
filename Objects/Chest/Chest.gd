extends BaseObject

var chest_open = preload("res://Objects/Chest/Assets/chest_open.png")

var open = false

func _use():
	if !open: open_chest()
		
func open_chest():
	open = true

	#LOOT
	var sword_instance = GLOBAL.get_random_sword()
	sword_instance.position = position
	get_tree().get_root().add_child(sword_instance)
	
	$Sprite.set_texture(chest_open)
	


