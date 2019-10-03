extends Control

var message setget _set_message

func _set_message(value):
	$ColorRect/Label.text = value
