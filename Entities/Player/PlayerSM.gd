extends StateMachine

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("crouch")
	call_deferred("set_state", states.idle)
	
func _input(event):
	
	#JUMP
	if [states.idle, states.run].has(state):
		if event.is_action_pressed("ui_up"):
			parent.motion.y = parent.JUMP_HEIGHT

	#USE (Chest, Sign ...)
	if event.is_action_pressed("use"):
		if parent.object_to_use:
			parent.object_to_use._use()
			
	#SHOOT
	if event.is_action_pressed("shoot"):
		var arrow_instance = GLOBAL._get_new_arrow($ArrowPoint.global_position, 5)
		arrow_instance.direction = sign($ArrowPoint.position.x)
		get_tree().get_root().add_child(arrow_instance)
	
	#INVENTORY
	if Input.is_action_pressed("toggle_inventory"):
		$Intenvory._toggle()
	
func _state_logic(delta):
	parent._apply_movement()
	parent._apply_gravity(delta)
	parent._handle_move_input()
	
func _get_transition(delta):
	match state:
		states.idle:
			if !parent._check_is_grounded():
				if parent.motion.y < 0:
					return states.jump
				else:
					return states.fall
			elif int(parent.motion.x) != 0:
				return states.run
			elif parent.is_crouched:
				return states.crouch
		states.run:
			if !parent._check_is_grounded():
				if parent.motion.y < 0:
					return states.jump
				else:
					return states.fall
			elif int(parent.motion.x) == 0:
				return states.idle
		states.jump:
			if parent._check_is_grounded():
				return states.idle
			if parent.motion.y >= 0:
				return states.fall
		states.fall:
			if parent._check_is_grounded():
				return states.idle
			elif parent.motion.y < 0:
				return states.jump
		states.crouch:
			if !parent.is_crouched:
				return states.idle

func _enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.anim_player.play("Idle")
		states.run:
			parent.anim_player.play("Run")
		states.jump:
			parent.anim_player.play("Jump")
		states.fall:
			parent.anim_player.play("Fall")
		states.crouch:		
			parent.anim_player.play("Crouch")