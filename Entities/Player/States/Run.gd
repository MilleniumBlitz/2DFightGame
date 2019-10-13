extends "Common.gd"



func _enter():
    owner.anim_player.play("Run")

func _handle_input(event):
    if event.is_action_pressed("jump"):
        emit_signal("finished", "jump")

func _update(delta):
    var move_direction = get_input_direction().x
    if move_direction != 0:
        update_sprite_direction(null)
        owner.motion.x = lerp(owner.motion.x, owner.ACCELERATION * delta * move_direction, _get_h_weight())
        owner.motion = owner.move_and_slide(owner.motion, owner.UP)
    else:
        emit_signal("finished", "idle")

        #Inverse the position of the arrow point
        # if (sign($ArrowPoint.position.x) == 1 and sign(move_direction) == -1) or (sign($ArrowPoint.position.x) == -1 and sign(move_direction) == 1):
        #     $ArrowPoint.position *= -1
            
        # $Sprite.flip_h = move_direction < 0
func _get_h_weight():
    return 0.8 if owner._check_is_grounded() else 0.8