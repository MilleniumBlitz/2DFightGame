extends RigidBody2D

var damage = 1

const SPEED = 200
var direction setget set_direction

func _process(delta):
	global_position += direction * SPEED * delta

func disable_colision():
	$CollisionPolygon2D.disabled = true

func set_direction(value):
	direction = value
	rotation = direction.angle()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Arrow_body_entered(body):


	# var target = global_position
	# get_tree().get_root().remove_child(self)
	
	# # var target = GLOBAL.map_to_world(position)
	
	# mode = Physics2DServer.BODY_MODE_KINEMATIC
	# body.call_deferred("set_contact_monitor" ,false)
	# self.disable_colision()
	# body.call_deferred("add_child", self)
	# global_position.x = target.x + 10
	# global_position.y = target.y


	if body.has_method("_hit"):
		body._hit(self, damage)
	# queue_free()
