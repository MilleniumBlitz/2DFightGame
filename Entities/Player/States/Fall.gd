extends "Common.gd"

func _enter():
    owner.anim_player.play("Fall")

func _update(delta):
    update_sprite_direction(null)
    owner.motion.x = lerp(owner.motion.x, owner.SPEED * get_input_direction().x, 10 * delta)
    owner.move_and_slide(owner.motion, owner.UP)
    if owner._check_is_grounded():
        emit_signal("finished", "idle")