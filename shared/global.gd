extends Node

const mouse_sensitivity = 0.05

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
