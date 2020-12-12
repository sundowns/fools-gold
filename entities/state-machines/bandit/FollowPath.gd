extends Node

var fsm: StateMachine

var path_node: PathFollow

func enter(e):
	var enemy_parent = e.get_parent()
	if enemy_parent is PathFollow:
		path_node = enemy_parent
		path_node.set_physics_process(true)
	else:
		exit(e, "Idle")

func exit(_e, next_state):
	path_node.set_physics_process(false)
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	e.apply_gravity(delta)
	e.apply_movement()
	if e.check_if_player_attackable():
		exit(e, "Attack")
		return

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
	
func entered_sight_range(e: Bandit, _params: Dictionary = {}):
	exit(e, "NavigateToPlayer")

func has_been_hurt(e: Bandit, _params: Dictionary = {}):
	exit(e, "NavigateToPlayer")
