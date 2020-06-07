extends Node

const levels_prefix = "Level"

var saved_levels = {}

var player

var tilemap

var start_level = 1

var arrow = preload("res://Entities/Arrow/Arrow.tscn")

func init_game():
	
	var player_res = preload("res://Entities/Player/Player.tscn")
	player = player_res.instance()
	
	var scene_path = "res://Levels/" + str(start_level) + "/Level" + str(start_level) + ".tscn"
	
	get_tree().change_scene(scene_path)
	
func map_to_world(position):
	return tilemap.map_to_world(position)

func change_scene(direction):
	var current_level = get_tree().get_current_scene()
	var level_number = current_level.name.trim_prefix(levels_prefix)
	saved_levels[level_number] = current_level
		
	current_level.remove_child(player)
	
	get_tree().get_root().remove_child(current_level)
	
	var new_scene = load(direction).instance()
	
	var new_scene_level_number = new_scene.name.trim_prefix(levels_prefix)
	if saved_levels.has(new_scene_level_number):
		new_scene = saved_levels[new_scene_level_number]
		
#	for node in new_scene.get_children():
#		node.set_physics_process(false)
		
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	
func _get_new_arrow(position, damage):
	var arrow_instance = arrow.instance()
	arrow_instance.global_position = position
	arrow_instance.damage = damage
	return arrow_instance
