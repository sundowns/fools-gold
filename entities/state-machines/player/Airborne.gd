extends Node

var fsm: StateMachine

func enter(e):
	e.velocity.y = 0

func exit(e, next_state):
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	e.aerial_movement(delta)
	e.apply_movement()
	if e.is_on_floor():
		exit(e, "Move")
		return

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
