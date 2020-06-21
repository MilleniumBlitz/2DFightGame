extends BaseLevel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var toto = load("res://Utils/debug overlay/Debug overlay.tscn").instance()
	toto.add_stat("Current object", player, "get_current_item", true)
	add_child(toto)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
