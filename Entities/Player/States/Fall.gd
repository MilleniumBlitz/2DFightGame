extends "Common.gd"

func _enter():
	owner.anim_player.play("Fall")

func _update(delta):
	update_sprite_direction()
	if owner._check_is_grounded():
		emit_signal("finished", "run")
	owner.motion.x = lerp(owner.motion.x, owner.MAX_SPEED * get_input_direction().x, owner.AIR_ACCELERATION * delta)
	owner.motion = owner.move_and_slide(owner.motion, owner.UP)
