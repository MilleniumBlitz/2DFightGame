extends Node2D

export(String, FILE, "*.tscn") var direction

func _on_body_entered(body):
	GLOBAL.call_deferred("change_scene", direction)
#	GLOBAL.change_scene(direction)