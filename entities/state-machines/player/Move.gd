extends Node

var fsm: StateMachine

func enter(_e):
	pass

func exit(e, next_state):
	if not e.just_jumped and next_state in ["Airborne"]:
		e.gravity_vector.y = 0
		e.just_fell = true
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	if not e.is_on_floor() and not e.ground_check.is_grounded():
		exit(e, "Airborne")
		return
	if e.direction == Vector3.ZERO:
		exit(e, "Idle")
		return
	e.calculate_slope_angle()
	e.apply_gravity(delta, e.slope_angle)
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
