extends Node2D

export(String) var message

signal enabled

func _ready():
	
	$Label.text = message
	
func _on_Sign_body_entered(body):
	if body.name == "Player":
		$Sign/Sprite.set_modulate(Color(255, 1, 1, 1))
		$AnimationPlayer.play("LabelShow")
		$Label.show()


func _on_Sign_body_exited(body):
	$Sign/Sprite.set_modulate(Color(1, 1, 1, 1))
	$Label.hide()
