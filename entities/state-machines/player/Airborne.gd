extends Node

var fsm: StateMachine

func enter(e):
	pass

func exit(e, next_state):
	e.just_jumped = false
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	if e.is_on_floor():
		exit(e, "Move")
		return
	e.aerial_movement(delta)
	e.apply_movement()
	e.just_jumped = false

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
