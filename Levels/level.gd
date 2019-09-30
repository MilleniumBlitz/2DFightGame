extends Node

export(NodePath) var default_spawn
export(Color) var level_color

func _ready():
		
	print("toto")
		
	if has_node("Player"):
		GLOBAL.player = find_node("Player")
	else:
		add_child(GLOBAL.player)
	
	if has_node("Light2D"):
		var light = find_node("Light2D")
		light.color = level_color
		
	var spawn_point = find_node(default_spawn)
	GLOBAL.player.position = spawn_point.global_position
