extends Area2D

var mouse_out = preload("res://UI/Inventory/Assets/inventory-case.png")
var mouse_hover = preload("res://UI/Inventory/Assets/inventory-case-over.png")

func _on_InventorySpace_mouse_entered():
	$Sprite.set_texture(mouse_hover)
	
func _on_InventorySpace_mouse_exited():
	$Sprite.set_texture(mouse_out)
