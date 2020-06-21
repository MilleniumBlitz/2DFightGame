extends "Common.gd"

var dash_distance = 20

func _enter():
	owner.anim_player.play("Attack")
	yield(get_tree().create_timer(0.3), "timeout")
	emit_signal("finished", "idle")

func _update(delta):
	update_sprite_direction()
	owner.motion.x = dash_distance  * owner.get_facing_direction().x
	owner.motion = owner.move_and_slide(owner.motion, owner.UP)
	