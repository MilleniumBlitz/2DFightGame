extends StateMachine

func _ready():
	add_state("idle", $Idle)
	add_state("dead", $Dead)
	call_deferred("new_state", "idle")