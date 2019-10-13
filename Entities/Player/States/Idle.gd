extends "Common.gd"

func _enter():
	owner.anim_player.play("Idle")

func _update(delta):
	if !owner._check_is_grounded():
		emit_signal("finished", "fall")
	if get_input_direction().x != 0:
		emit_signal("finished", "run")

func _handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	elif event.is_action_pressed("crouch"):
		emit_signal("finished", "crouch")