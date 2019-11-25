extends RigidBody2D

var damage = 1

const SPEED = 250
var direction = 1 setget _set_direction

func _ready():
	apply_impulse(Vector2.ZERO, Vector2(SPEED * direction, 0))
	
func disable_colision():
	$CollisionPolygon2D.disabled = true


func _set_direction(dir):
	direction = dir
	
func _on_VisibilityNotifier2D_screen_exited():
	pass
	# queue_free()

func _on_Arrow_body_entered(body):
	print("toto")
	var target = global_position
	get_tree().get_root().remove_child(self)
	
	# var target = GLOBAL.map_to_world(position)
	print()
	
	mode = Physics2DServer.BODY_MODE_KINEMATIC
	# body.call_deferred("set_contact_monitor" ,false)
	self.disable_colision()
	body.call_deferred("add_child", self)
	global_position.x = target.x + 10
	global_position.y = target.y


	if body.has_method("_hit"):
		body._hit(self, damage)
	# queue_free()