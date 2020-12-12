extends Node

var fsm: StateMachine

func enter(e):
	pass
#	print(e.velocity, e.gravity_vector)

func exit(_e, next_state):
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	e.apply_gravity(delta)
#	print(e.velocity, " , " , e.gravity_vector)
#	e.handle_jump()
	e.grounded_movement(delta)
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
