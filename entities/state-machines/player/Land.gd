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
#	e.handle_jump()
	e.check_for_slope()
	e.apply_gravity(delta)
	e.grounded_movement(delta, e.angle_to_normal_from_up)
	e.apply_movement()
	exit(e, "Move")

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
