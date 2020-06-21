extends "Common.gd"

func _enter():
	owner.anim_player.play("Idle")

func _update(delta):
	update_sprite_direction()
	# owner.motion.x = lerp(owner.motion.x, 0, owner.DECELERATION * delta)
	owner.motion.x = 0
	owner.motion = owner.move_and_slide(owner.motion, owner.UP)
	
	if !owner._check_is_grounded():
		emit_signal("finished", "fall")
	if get_input_direction().x != 0 and owner.can_move:
		emit_signal("finished", "run")

func _handle_input(event):
	._handle_input(event)
	if event.is_action_pressed("jump") and owner.can_move:
		emit_signal("finished", "jump")
	elif event.is_action_pressed("crouch"):
		emit_signal("finished", "crouch")
