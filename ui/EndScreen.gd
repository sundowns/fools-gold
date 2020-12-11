extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Timer_timeout():
	$Button.disabled = false

func _on_Button_pressed():
	get_tree().quit()
