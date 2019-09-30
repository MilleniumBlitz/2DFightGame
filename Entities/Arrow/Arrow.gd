extends Area2D

var damage = 1

const SPEED = 250
var velocity = Vector2()
var direction = 1 setget _set_direction
	
func _set_direction(dir):
	direction = dir
	
func _physics_process(delta):
	velocity.x = SPEED * delta *  direction
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Arrow_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
	queue_free()



