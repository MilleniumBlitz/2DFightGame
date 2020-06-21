extends Node

class_name BaseObject

var object_name = ""

signal in_range(chest)
signal out_range()

func _ready():
	connect("in_range", GLOBAL.player, "on_object_in_range")
	connect("out_range", GLOBAL.player, "on_object_out_range")
	connect("body_entered", self, "_on_Area2D_body_entered")
	connect("body_exited", self, "_on_Area2D_body_exited")

func _on_Area2D_body_entered(body):
	print("ousdsd")
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