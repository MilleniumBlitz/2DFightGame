extends Node

class_name BaseObject

signal in_range(chest)
signal out_range()

func _ready():
	
	if has_node("Area2D"):
		var area = get_node("Area2D")
		area.connect("body_entered", self, "_on_Area2D_body_entered")
		area.connect("body_exited", self, "_on_Area2D_body_exited")

func _on_Area2D_body_entered(body):
	if body.name == GLOBAL.player.name:
		_on_player_on()
		emit_signal("in_range", self)
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		_on_player_out()
		emit_signal("out_range")

func _on_player_on():
	pass
	
func _on_player_out():
	pass

func _use():
	pass