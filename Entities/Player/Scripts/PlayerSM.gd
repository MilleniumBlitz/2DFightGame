extends StateMachine

var input_direction

func _ready():
	add_state("idle", $Idle)
	add_state("run", $Run)
	add_state("jump", $Jump)
	add_state("doublejump", $DoubleJump)
	add_state("fall", $Fall)
	add_state("crouch", $Crouch)
	add_state("dash", $Dash)
	add_state("attack", $Attack)
	call_deferred("new_state", "idle")

func _input(event):
	state._handle_input(event)

	#USE (Chest, Sign ...)
	if event.is_action_pressed("use"):
		if parent.object_to_use:
			parent.object_to_use._use()

	#INVENTORY

	if event.is_action_pressed("toggle_inventory"):
		parent.toggle_inventory()

	if event.is_action_pressed("previous_item"):
		
		var curr_index = owner.items.find(owner.current_item)
		if curr_index == 0:
			owner.current_item = owner.items[owner.items.size() - 1]
		else:
			owner.current_item = owner.items[curr_index - 1]

	if event.is_action_pressed("next_item"):

		var curr_index = owner.items.find(owner.current_item)
		var next_index = curr_index + 1
		if next_index < owner.items.size():
			owner.current_item = owner.items[next_index]
		else:
			owner.current_item = owner.items[0]


func _physics_process(delta):
	parent._apply_gravity(delta)
	# shoot_cooldown.tick(delta)
	input_direction = Vector2(int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
				int(Input.is_action_pressed("action_down")) - int(Input.is_action_pressed("action_up")))

	
	
