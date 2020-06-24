extends Area2D

var mouse_out = preload("res://UI/Inventory/Assets/inventory-case.png")
var mouse_hover = preload("res://UI/Inventory/Assets/inventory-case-over.png")

var item setget set_item

func set_item(value):
	item = value
	item.position = Vector2(0,0)
	item.scale = Vector2(0.5, 0.5)
	item.rotation = 0.5
	add_child(item)

func _on_InventorySpace_mouse_entered():
	$Sprite.set_texture(mouse_hover)
	
func _on_InventorySpace_mouse_exited():
	$Sprite.set_texture(mouse_out)
