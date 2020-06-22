extends "Common.gd"

func _enter():
	owner.double_jumped = true
	owner.motion.y = owner.JUMP_HEIGHT
	owner.anim_player.play("Jump")

func _update(delta):
	update_sprite_direction()

	owner.motion.x = lerp(owner.motion.x, owner.MAX_SPEED * sign(get_input_direction().x),  owner.AIR_ACCELERATION * delta)
	owner.motion = owner.move_and_slide(owner.motion, owner.UP)

	if owner.motion.y >= 0:
		emit_signal("finished", "fall")
