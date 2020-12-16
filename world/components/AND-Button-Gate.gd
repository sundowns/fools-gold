extends Spatial

var one_is_pressed := false
var two_is_pressed := false
export(float) var time_to_press_both := 30

signal both_pressed
signal was_reset

func _process(delta):
	if one_is_pressed and two_is_pressed:
		broadcast()

func reset():
	one_is_pressed = false
	two_is_pressed = false
	emit_signal("was_reset")

func broadcast():
	$Timer.stop()
	print('dingers')
	set_process(false)
	emit_signal("both_pressed")

func press_one():
	one_is_pressed = true
	$Timer.start(time_to_press_both)

func press_two():
	two_is_pressed = true
	$Timer.start(time_to_press_both)

func _on_Timer_timeout():
	reset()

