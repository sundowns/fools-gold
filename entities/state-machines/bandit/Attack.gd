extends Node

var fsm: StateMachine

func enter(e):
	e.velocity = Vector3.ZERO

func exit(_e, next_state):
	fsm._change_to(next_state)

# Optional handler functions for game loop events
func process(e, delta):
	e.animated_sprite.play("attack")
	# Add handler code here
	return delta

func physics_process(e, delta):
	e.apply_gravity(delta)
	e.run_at_player()
	e.apply_movement()
	
	if e.has_los_to_player:
		e.swing_at_the_cunt()
	else:
		# Switch back to Navigate To Player if we lose LOS
		exit(e, "NavigateToPlayer")

func input(_e, event):
	return event

func unhandled_input(_e, event):
	return event

func unhandled_key_input(_e, event):
	return event

func notification(what, flag = false):
	return [what, flag]
