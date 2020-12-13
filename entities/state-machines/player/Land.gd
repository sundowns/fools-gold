extends Node

var fsm: StateMachine


func enter(e):
	if not e.slope_cast.is_colliding():
		exit(e, "Airborne")

func exit(_e, next_state):
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	e.calculate_slope_angle()
	e.apply_gravity(delta, e.slope_angle)
	e.grounded_movement(delta)
	e.apply_movement(true)
	exit(e, "Move")

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
