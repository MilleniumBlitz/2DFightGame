extends BaseObject
tool
var message_ui = preload("res://UI/Message/Message.tscn")

export(String) var message = "" setget set_message

func _use():
	var message_ui_instance = message_ui.instance()
	message_ui_instance.message = message
	get_tree().get_root().add_child(message_ui_instance)
	print(message)
	
func set_message(value):
	message = value
	$Label.text = message

func _on_player_on():
	$Label.show()
	
func _on_player_out():
	$Label.hide()
