extends Node

const levels_prefix = "Level"

var saved_levels = {}

var player

var tilemap

var start_level = 1

var swords = {}

var sword = preload("res://Weapons/Sword/Sword.tscn")
var arrow = preload("res://Entities/Projectile/Arrow/Arrow.tscn")
var bullet = preload("res://Entities/Projectile/Bullet/Bullet.tscn")

func init_game():
	load_swords()
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
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = position
	get_tree().get_root().add_child(bullet_instance)
	return bullet_instance
	# var arrow_instance = arrow.instance()
	# arrow_instance.global_position = position
	# arrow_instance.damage = damage
	# return arrow_instance

func get_random_sword():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	print(swords.size())
	var random = swords[rng.randi_range (0, swords.size()-1)]
	var sword_instance = sword.instance()
	sword_instance.item_name = random.name
	sword_instance.color = random.color
	sword_instance.damage = random.damage
	return sword_instance
	

func load_swords():
	var data_file = File.new()
	if data_file.open("res://Weapons/swords.json", File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	swords = data_parse.result["swords"]
