extends Node

class_name BaseLevel

export(NodePath) var default_spawn
export(Color) var level_color

func _enter_tree():
	
	add_child(GLOBAL.player)
	
	if has_node("Light2D"):
		var light = find_node("Light2D")
		light.color = level_color
	
	var spawn_point = find_node(default_spawn)
	GLOBAL.player.position = spawn_point.position

func _ready():
	
	for object in get_tree().get_nodes_in_group("UsableObject"):
		object.connect("in_range", GLOBAL.player, "on_object_in_range")
		object.connect("out_range", GLOBAL.player, "on_object_out_range")