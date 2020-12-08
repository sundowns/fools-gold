extends Node

var fsm: StateMachine

onready var path_calc_timer: Timer = $PathRecalculateTimer
var should_recalculate_path := false

func enter(e):
	e.velocity = Vector3.ZERO
	e.calculate_path_to_player()
	path_calc_timer.start()

func exit(e, next_state):
	path_calc_timer.stop()
	e.reset_path()
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	if e.check_if_player_attackable():
		exit(e, "Attack")
		return
	
	if should_recalculate_path:
		e.calculate_path_to_player()
		should_recalculate_path = false
	
	e.apply_gravity(delta)
	
	var path_exists = e.follow_path()
	e.apply_movement()
	
	if not path_exists:
		exit(e, "Idle")
		return

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]

func _on_PathRecalculateTimer_timeout():
	should_recalculate_path = true
	path_calc_timer.start()
