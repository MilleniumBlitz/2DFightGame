extends Sprite

var items = []


func toggle():
	set_visible(!visible)
	
func add_item(item):
	items.append(item)
	var index = items.size() - 1
	var inventory_space = get_node("InventorySpace" + str(index))
	print("oui")
	if inventory_space:
		inventory_space.item = item
