extends "Common.gd"

var dash_distance = 2000
var previous_motion

func _enter():
	previous_motion = owner.motion.x
	
	
	

func _update(delta):
	update_sprite_direction()
	owner.motion.x = dash_distance  * owner.get_facing_direction().x
	owner.motion = owner.move_and_slide(owner.motion, owner.UP)
	owner.motion.x = previous_motion
	if owner._check_is_grounded():
		emit_signal("finished", "run")
	else:
		emit_signal("finished", "fall")
