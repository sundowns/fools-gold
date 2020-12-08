extends Control

onready var main_pause_menu = $Main
onready var options_menu = $OptionsMenu

var is_paused = false
var can_cancel = true

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_paused:
			if can_cancel:
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

func _on_OptionsMenu_options_closed():
	main_pause_menu.visible = true
	can_cancel = true

func _on_OptionsButton_pressed():
	main_pause_menu.visible = false
	can_cancel = false
	options_menu.visible = true
	
