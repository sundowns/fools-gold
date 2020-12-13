extends Node

var fsm: StateMachine

onready var timer: Timer = $Timer
var exit_to_airborne := false

func enter(e):
	e.just_jumped = true
	exit_to_airborne = false
	timer.start()

# warning-ignore:unused_argument
func exit(e, next_state):
	exit_to_airborne = false
	timer.stop()
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(_e, delta):
	# Add handler code here
	return delta

func physics_process(e, delta):
	if exit_to_airborne:
		exit(e, "Airborne")
		return
	e.aerial_movement(delta)
	e.apply_movement(false)

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]

func _on_Timer_timeout():
	exit_to_airborne = true
