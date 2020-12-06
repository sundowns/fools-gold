extends Node

var fsm: StateMachine

onready var just_jumped_timer: Timer = $JumpStartTimer
onready var just_fell_timer: Timer = $JustFellTimer

var no_longer_just_jumped := false
var no_longer_just_fell := false

func enter(_e):
	just_jumped_timer.start()
	just_fell_timer.start()
	no_longer_just_jumped = false
	no_longer_just_fell = false

func exit(e, next_state):
	just_jumped_timer.stop()
	just_fell_timer.stop()
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(e, delta):
	return delta

func physics_process(e, delta):
	if no_longer_just_jumped:
		e.just_jumped = false
	if no_longer_just_fell:
		e.just_fell = false
	if e.just_fell:
		e.handle_jump()
	e.apply_gravity(delta)
	e.aerial_movement(delta)
	e.apply_movement()
	if not e.just_jumped and (e.is_on_floor() or e.ground_check.is_grounded()):
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

func _on_JumpStartTimer_timeout():
	no_longer_just_jumped = true

func _on_JustFellTimer_timeout():
	no_longer_just_fell = true
