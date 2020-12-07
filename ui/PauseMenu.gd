extends Control

var is_paused = false

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_paused:
			unpause_game()
		else:
			pause_game()

func unpause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_paused = false
	self.visible = false
	get_tree().paused = false

func pause_game():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	is_paused = true
	self.visible = true
	get_tree().paused = true

func _on_ResumeButton_pressed():
	unpause_game()

func _on_ExitButton_pressed():
	get_tree().quit()
