extends "Common.gd"

func _enter():
	owner.anim_player.play("Run")

func _handle_input(event):
	._handle_input(event)
	#TODO Implement slide from here
	if event.is_action_pressed("jump"):
		emit_signal("finished", "jump")
	elif event.is_action_pressed("crouch"):
		emit_signal("finished", "crouch")

func _update(delta):
	update_sprite_direction()

	var move_direction = get_input_direction().x
	if move_direction != 0:
		owner.motion.x = lerp(owner.motion.x, owner.MAX_SPEED * move_direction, owner.ACCELERATION * delta)
		owner.motion = owner.move_and_slide(owner.motion, owner.UP)
	else:
		emit_signal("finished", "idle")
