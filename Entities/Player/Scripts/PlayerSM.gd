extends StateMachine

var input_direction

func _ready():
	add_state("idle", $Idle)
	add_state("run", $Run)
	add_state("jump", $Jump)
	add_state("fall", $Fall)
	add_state("crouch", $Crouch)
	call_deferred("new_state", "idle")
	
func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
		var q0 = p0.linear_interpolate(p1, t)
		var q1 = p1.linear_interpolate(p2, t)
		var r = q0.linear_interpolate(q1, t)
		return r

func _input(event):
	
	state._handle_input(event)

	#USE (Chest, Sign ...)
	if event.is_action_pressed("use"):
		if parent.object_to_use:
			parent.object_to_use._use()
			
	if event.is_action_pressed("hold_bow"):
		owner.can_move = false
		owner.aim_arrow_visible = true

	if event.is_action_released("hold_bow"):
		var arrow_instance = GLOBAL._get_new_arrow(owner.get_global_shooting_position(), 5)
		arrow_instance.direction = owner.local_shooting_position.normalized()
		get_tree().get_root().add_child(arrow_instance)

		var p1 = owner.local_shooting_position
		print(p1)

		var p2 = owner.local_shooting_position * 10
		print(p2)

		var p3 = p2
		p3.y += 40

		var t = 0
		for i in range(10):
			owner.move_toto(_quadratic_bezier(p1, p2, p3, t))
			t += 0.1


		owner.aim_arrow_visible = false
		owner.can_move = true

	var deadzone = 0.3
	

	#EMPLACEMENT DE LA FLECHE DE VISEE
	if owner.aim_arrow_visible and event is InputEventJoypadMotion:
		var arrow_position = owner.local_shooting_position

		#VERTICAL
		if event.axis == JOY_AXIS_1:
			if event.axis_value < -deadzone:
				arrow_position.y = -20
			elif event.axis_value > deadzone:
				arrow_position.y = 20
			else:
				arrow_position.y = 0

		#HORIZONTAL
		if event.axis == JOY_AXIS_0:
			if event.axis_value < -deadzone:
				arrow_position.x = -20
			elif event.axis_value > deadzone:
				arrow_position.x = 20
			else:
				arrow_position.x = 0
		
		owner.local_shooting_position = arrow_position
		
	#INVENTORY
	if event.is_action_pressed("toggle_inventory"):
		parent.toggle_inventory()

func _physics_process(delta):
	parent._apply_gravity(delta)
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
				int(Input.is_action_pressed("action_down")) - int(Input.is_action_pressed("action_up")))
	
