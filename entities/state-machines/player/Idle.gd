extends Node

var fsm: StateMachine

func enter(e):
	pass

func exit(_e, next_state):
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	if not e.is_on_floor():
		exit(e, "Airborne")
		return
	if e.direction != Vector3.ZERO:
		exit(e, "Move")
		return
	e.handle_jump()
	e.grounded_movement(delta)
	e.apply_movement()

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
