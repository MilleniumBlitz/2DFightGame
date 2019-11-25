extends Node

class_name BaseLevel



var light_texture = preload("res://Utils/light.png")

export(float,0,10) var level_brightness setget _set_level_brightness
export(Color) var level_color setget _set_level_color

onready var tile_map = $TileMap

func _enter_tree():

	if has_node("Light2D"):
		var light = find_node("Light2D")
		light.color = level_color
	add_child(GLOBAL.player)
	GLOBAL.player.position = $DefaultSpawn.position
#	$Player.call_deferred("replace_by", GLOBAL.player)
#	$Player.replace_by(GLOBAL.player)
	
#	if has_node("Player"):
#		GLOBAL.player = $Player
#	else:
#		add_child(GLOBAL.player)


			
func _ready():
	
	GLOBAL.tilemap = $TileMap

	#Light system
	var cell_positions = tile_map.get_used_cells()
	for pos in cell_positions:	
		var tile_id = tile_map.get_cellv(pos)
		var tile_name = tile_map.get_tileset().tile_get_name(tile_id)
#		tile_map.get_tileset().tile_set_modulate(tile_id, level_color)
		if tile_name == "Torch":
			var light = Light2D.new()
			light.texture = light_texture
			light.position = tile_map.map_to_world(pos)
			light.texture_scale = 0.1
			light.energy = level_brightness
			light.color = level_color
			light.shadow_enabled = true
			$Lights.add_child(light)
			pass
	
	for object in get_tree().get_nodes_in_group("UsableObject"):
		object.connect("in_range", GLOBAL.player, "on_object_in_range")
		object.connect("out_range", GLOBAL.player, "on_object_out_range")
		
func _set_level_brightness(value):
	level_brightness = value
	set_torches_color()
	
func _set_level_color(value):
	level_color = value
	set_torches_color()
	
func set_torches_color():
	for torche in $Lights.get_children():
		torche.color = level_color
		torche.energy = level_brightness




