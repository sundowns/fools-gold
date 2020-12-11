extends Control

onready var timer: Timer = $Timer

func _ready():
	visible = false

func request_show():
	timer.start()

func show():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Button.disabled = false

func hide():
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Button.disabled = true

func _on_Button_pressed():
	hide()
	timer.stop()
	LevelManager.level_restarted()

func _on_Timer_timeout():
	show()
