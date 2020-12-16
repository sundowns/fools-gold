extends Spatial

var one_is_pressed := false
var two_is_pressed := false

signal both_pressed

func _process(delta):
	if one_is_pressed and two_is_pressed:
		broadcast()

func reset():
	one_is_pressed = false
	two_is_pressed = false

func broadcast():
	print('dingers')
	set_process(false)
	emit_signal("both_pressed")

func press_one():
	one_is_pressed = true

func press_two():
	two_is_pressed = true

func _on_Timer_timeout():
	reset()
