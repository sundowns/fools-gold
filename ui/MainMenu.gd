extends Control

onready var menu = $Buttons
onready var options_menu = $OptionsMenu

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_OptionsMenu_options_closed():
	menu.visible = true

func _on_OptionsButton_pressed():
	menu.visible = false
	options_menu.open_menu()
	
func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game.tscn")
