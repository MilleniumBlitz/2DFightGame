extends Node2D

class_name Item

signal in_range(item)

var picked setget set_picked
var item_name

func _ready():
	connect("in_range", GLOBAL.player, "on_item_in_range")
    
func _on_Item_body_entered(body):
    if body.name == GLOBAL.player.name:
        emit_signal("in_range", self)

func set_picked(value):
    picked = value
    if picked:
        get_parent().remove_child(self)