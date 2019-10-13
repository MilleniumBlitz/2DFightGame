extends "Common.gd"

func _enter():
    owner.motion.y = owner.JUMP_HEIGHT
    owner.anim_player.play("Jump")

func _update(delta):
    update_sprite_direction(null)
    owner.motion.x = owner.ACCELERATION * delta * get_input_direction().x
    owner.move_and_slide(owner.motion, owner.UP)

    if owner.motion.y >= 0:
        emit_signal("finished", "fall")