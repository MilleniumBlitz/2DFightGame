extends BaseObject

var chest_open = preload("res://Objects/Chest/Assets/chest_open.png")

var open = false

func _use():
	open_chest()
		
func open_chest():
	if !open:
		open = true
		print("ouverture du coffre")
		$Sprite.set_texture(chest_open)
	else:
		print("coffre déjà ouvert")
	


