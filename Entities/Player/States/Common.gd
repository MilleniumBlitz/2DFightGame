extends State

func get_input_direction():
    return get_parent().input_direction

# Returns true if direction changed.
func update_sprite_direction(direction):
	var last_facing_direction = get_input_direction()
	if last_facing_direction.x == 1:
		owner.sprite.flip_h = false
	elif last_facing_direction.x == -1:
		owner.sprite.flip_h = true
    # sprite.offset.x = owner.get_facing_direction().x * abs(sprite.offset.x)
    # return last_facing_direction != owner.get_facing_direction()