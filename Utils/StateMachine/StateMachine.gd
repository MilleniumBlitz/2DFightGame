extends Node

class_name StateMachine

var state = null
var previous_state = null
var states = {}

# warning-ignore:unused_class_variable
onready var parent = get_parent()

func _physics_process(delta):
	state._update(delta)
		
func new_state(new_state_name):
	print("nouveau state : " +  new_state_name)
	previous_state = state
	state = states[new_state_name]
	if previous_state != null:
		previous_state._exit()
	if new_state_name != null:
		state._enter()

func add_state(state_name, state_node):
	states[state_name] = state_node
	state_node.connect("finished", self, "new_state")
