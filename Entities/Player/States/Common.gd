extends State

func get_input_direction():
    return get_parent().input_direction

# Returns true if direction changed.
func update_sprite_direction():

	var last_facing_direction = get_input_direction()
	if last_facing_direction.x == 1:
		owner.sprite.flip_h = false
	elif last_facing_direction.x == -1:
		owner.sprite.flip_h = true

	#Inverse the position of the arrow point
	var shooting_position = owner.local_shooting_position
	if (sign(shooting_position.x) == 1 and sign(last_facing_direction.x) == -1) or (sign(shooting_position.x) == -1 and sign(last_facing_direction.x) == 1):
		owner.local_shooting_position *= -1
	
