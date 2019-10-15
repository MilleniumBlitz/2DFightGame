extends "Common.gd"

var player_speed = 200
var acceleration = 5

func _enter():
    owner.anim_player.play("Run")

func _handle_input(event):
    if event.is_action_pressed("jump"):
        emit_signal("finished", "jump")

func _update(delta):
    update_sprite_direction(null)
    var move_direction = get_input_direction().x
    if move_direction != 0:
        owner.motion.x = lerp(owner.motion.x, player_speed * move_direction, acceleration * delta)
        owner.motion = owner.move_and_slide(owner.motion, owner.UP)
    else:
        # owner.motion.x = lerp(owner.motion.x, 0, acceleration * delta)
        emit_signal("finished", "idle")

    

func _get_h_weight():
    return 0.2 if owner._check_is_grounded() else 0.8