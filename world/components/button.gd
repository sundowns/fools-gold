extends Spatial

signal activated

var is_pressed := false
export(bool) var one_shot := true

func activate():
	if is_pressed and one_shot:
		return
	is_pressed = true
	emit_signal("activated")
	print("Button pressed...") 
