extends Area2D

export var mass = 15

var velocity = Vector2(0, 0)
var toto = 5
var damage = 1


const SPEED = 2
var direction setget set_direction

func _enter_tree():
	velocity = direction * SPEED

	var p3 = (position * SPEED)
	p3.x += 10
	p3.y -= 10
	
	
	# print(position)
	# print(position *  SPEED)
	# print(p3)
	print(_quadratic_bezier(position, position * SPEED, p3, 0.5))

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.linear_interpolate(p1, t)
	var q1 = p1.linear_interpolate(p2, t)
	var r = q0.linear_interpolate(q1, t)
	return r

func _process(delta):
	
	# # Update: delta is also needed here
	# toto = lerp(toto, 0, 0.1)
	# velocity += gravity_vec*gravity*mass*delta
		
	# position += velocity *delta

	# rotation = velocity.angle()
	pass
			

func disable_colision():
	$CollisionPolygon2D.disabled = true

func set_direction(value):
	direction = value
	rotation = direction.angle()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Arrow_body_entered(body):


	# # var target = global_position
	# get_tree().get_root().remove_child(self)
	
	# var target = GLOBAL.map_to_world(position)
	
	# # mode = Physics2DServer.BODY_MODE_KINEMATIC
	# # body.call_deferred("set_contact_monitor" ,false)
	# self.disable_colision()
	# body.call_deferred("add_child", self)
	# global_position.x = target.x + 10
	# global_position.y = target.y


	if body.has_method("_hit"):
		body._hit(self, damage)
	# queue_free()



	
