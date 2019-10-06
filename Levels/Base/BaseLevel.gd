extends Node

class_name BaseLevel

export(Color) var level_color

func _enter_tree():

	if has_node("Light2D"):
		var light = find_node("Light2D")
		light.color = level_color
		
	GLOBAL.player.position = $DefaultSpawn.position
	add_child(GLOBAL.player)
#	$Player.call_deferred("replace_by", GLOBAL.player)
#	$Player.replace_by(GLOBAL.player)
	
#	if has_node("Player"):
#		GLOBAL.player = $Player
#	else:
#		add_child(GLOBAL.player)
		

func _ready():
	
	for object in get_tree().get_nodes_in_group("UsableObject"):
		object.connect("in_range", GLOBAL.player, "on_object_in_range")
		object.connect("out_range", GLOBAL.player, "on_object_out_range")