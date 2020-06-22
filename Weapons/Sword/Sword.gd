extends Item

var color setget set_color
var damage 

func set_color(value):
	$Sprite.modulate = value

func get_color():
	return $Sprite.modulate


