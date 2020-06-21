extends "Common.gd"

func _enter():
    owner.anim_player.play("Crouch")

func _handle_input(event):
    if event.is_action_released("crouch"):
        emit_signal("finished", "idle")

func _update(delta):
    update_sprite_direction()