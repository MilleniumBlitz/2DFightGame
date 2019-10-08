extends BaseNPC

onready var label = $Label

func _ready():
	label.visible = false

func _use():
	._use()
	label.text = "Vous vous foutez de moi"

func _on_player_on():
	label.visible = true

func _on_player_out():
	label.visible = false

