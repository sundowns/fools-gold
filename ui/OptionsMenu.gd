extends Control

signal options_closed
signal sensitivity_changed(new_sens_multiplier)

func _ready():
# warning-ignore:return_value_discarded
	connect("sensitivity_changed", Global, "_on_sensitivity_changed")
	$Sensitivity/HSlider.value = Global.sens_multiplier
	pause_mode = Node.PAUSE_MODE_PROCESS

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		close_menu()

func close_menu():
	self.visible = false
	emit_signal("options_closed")

func _on_BackButton_pressed():
	close_menu()

func _on_HSlider_value_changed(value):
	emit_signal("sensitivity_changed", value)
