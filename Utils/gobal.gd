extends Node

var levels_prefix = "Level"

var saved_levels = {}

var level = preload("res://Levels/level.gd")



var player
var previous_level

var arrow = preload("res://Entities/Arrow/Arrow.tscn")

func change_scene(direction):
	
	
	
	var current_level = get_tree().get_current_scene()
	var level_number = current_level.name.trim_prefix(levels_prefix)
	saved_levels[level_number] = current_level
	previous_level = current_level
	current_level.remove_child(player)
	
	get_tree().get_root().remove_child(current_level)
	
	var new_scene = load(direction).instance()
	var new_scene_level_number = new_scene.name.trim_prefix(levels_prefix)
	if saved_levels.has(new_scene_level_number):
		new_scene = saved_levels[new_scene_level_number]
	get_tree().get_root().add_child( new_scene )
	get_tree().set_current_scene( new_scene )
	
	var spawn_point = new_scene.find_node(new_scene.default_spawn)
	GLOBAL.player.position = spawn_point.global_position


func _get_new_arrow(position, damage):
	var arrow_instance = arrow.instance()
	arrow_instance.position = position
	arrow_instance.damage = damage
	return arrow_instance