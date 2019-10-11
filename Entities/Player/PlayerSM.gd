extends StateMachine

signal interact

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	add_state("crouch")
	add_state("dead")
	call_deferred("set_state", states.idle)
	
func _input(event):
	
	#JUMP
	if [states.idle, states.run].has(state):
		if event.is_action_pressed("jump"):
			parent.motion.y = parent.JUMP_HEIGHT

	#USE (Chest, Sign ...)
	if event.is_action_pressed("use"):
		if parent.object_to_use:
			parent.object_to_use._use()
			
	#SHOOT
	if event.is_action_pressed("shoot") && !event.is_echo():
		var arrow_instance = GLOBAL._get_new_arrow(parent.get_shooting_position(), 5)
		arrow_instance.direction = sign(parent.get_facing_direction().x)
		get_tree().get_root().add_child(arrow_instance)
	
	#INVENTORY
	if event.is_action_pressed("toggle_inventory"):
		var toto : Player = parent
		parent.toggle_inventory()
	
func _state_logic(delta):
	parent._handle_move_input(delta)
	parent._apply_movement()
	parent._apply_gravity(delta)
	
	
func _get_transition(delta):
	match state:
		states.idle:
			if !parent._check_is_grounded():
				print("not grounded")
				if parent.motion.y < 0:
					return states.jump
				else:
					return states.fall
			elif !Tools.is_equal(parent.motion.x,0):
				return states.run
			elif parent.is_crouched:
				return states.crouch
		states.run:
			if !parent._check_is_grounded():
				if parent.motion.y < 0:
					return states.jump
				else:
					return states.fall
			elif Tools.is_equal(parent.motion.x,0):
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