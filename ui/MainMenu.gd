extends Control

onready var menu = $Main
onready var options_menu = $OptionsMenu

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_OptionsMenu_options_closed():
	menu.visible = true

func _on_OptionsButton_pressed():
	menu.visible = false
	options_menu.open_menu()
	
func _on_StartButton_pressed():
	print("Start the dang game")
