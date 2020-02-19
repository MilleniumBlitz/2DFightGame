extends "Common.gd"


var player_speed = 200
var acceleration = 18

func _enter():
	owner.motion.y = owner.JUMP_HEIGHT
	owner.anim_player.play("Jump")

func _update(delta):
	update_sprite_direction()
	owner.motion.x = lerp(owner.motion.x, player_speed * get_input_direction().x, acceleration * delta)
	owner.move_and_slide(owner.motion, owner.UP)

	if owner.motion.y >= 0:
		emit_signal("finished", "fall")

func _get_h_weight():
	return 0.2 if owner._check_is_grounded() else 0.8
