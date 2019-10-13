extends RigidBody2D

var damage = 1

const SPEED = 250
var direction = 1 setget _set_direction

func _ready():
	apply_impulse(Vector2.ZERO, Vector2(SPEED * direction, 0))
	
func _set_direction(dir):
	direction = dir
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Arrow_body_entered(body):
	if body.has_method("_hit"):
		body._hit(damage)
	queue_free()