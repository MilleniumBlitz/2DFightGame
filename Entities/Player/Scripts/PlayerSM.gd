extends StateMachine

var input_direction

var can_fire = true

func _ready():
	add_state("idle", $Idle)
	add_state("run", $Run)
	add_state("jump", $Jump)
	add_state("fall", $Fall)
	add_state("crouch", $Crouch)
	call_deferred("new_state", "idle")
	
func _input(event):
	
	state._handle_input(event)

	#USE (Chest, Sign ...)
	if event.is_action_pressed("use"):
		if parent.object_to_use:
			parent.object_to_use._use()
			
	#SHOOT
	if event.is_action_pressed("shoot") && !event.is_echo() and can_fire:
		can_fire = false
		print(parent.get_global_shooting_position())
		var arrow_instance = GLOBAL._get_new_arrow(parent.get_global_shooting_position(), 5)
		arrow_instance.direction = sign(parent.get_facing_direction().x)
		get_tree().get_root().add_child(arrow_instance)
		yield(get_tree().create_timer(parent.fire_rate),"timeout")
		can_fire = true
	
	#INVENTORY
	if event.is_action_pressed("toggle_inventory"):
		parent.toggle_inventory()

func _physics_process(delta):
	parent._apply_gravity(delta)
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
				int(Input.is_action_pressed("action_down")) - int(Input.is_action_pressed("action_up")))
	