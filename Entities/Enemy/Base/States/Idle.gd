extends State

func _update(delta):
	if owner.health <= 0:
		emit_signal("finished", "dead")