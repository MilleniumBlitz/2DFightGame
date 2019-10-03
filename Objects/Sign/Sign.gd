extends BaseObject

var message_ui = preload("res://UI/Message/Message.tscn")

export(String) var message

func _ready():
	$Label.text = message
	
func _use():
	var message_ui_instance = message_ui.instance()
	message_ui_instance.message = message
	get_tree().get_root().add_child(message_ui_instance)
	print(message)
	
func _on_player_on():
	$Area2D/Sprite.set_modulate(Color(255, 1, 1, 1))
	$AnimationPlayer.play("LabelShow")
	$Label.show()
	
func _on_player_out():
	$Area2D/Sprite.set_modulate(Color(1, 1, 1, 1))
	$Label.hide()
