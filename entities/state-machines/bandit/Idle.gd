extends Node

var fsm: StateMachine

func enter(e):
	e.velocity = Vector3.ZERO
	var player_is_in_nav_range = e.check_if_player_in_PlayerChaseDetectionZone()
	if player_is_in_nav_range:
		exit(e, "NavigateToPlayer")
		return

func exit(_e, next_state):
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
