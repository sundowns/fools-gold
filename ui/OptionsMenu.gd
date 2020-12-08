extends Control

onready var fullscreen_menubutton = $FullScreen/MenuButton

signal options_closed
signal sensitivity_changed(new_sens_multiplier)

func _ready():
# warning-ignore:return_value_discarded
	connect("sensitivity_changed", Global, "_on_sensitivity_changed")
	$Sensitivity/HSlider.value = Global.sens_multiplier
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	fullscreen_menubutton.get_popup().add_item("Windowed")
	fullscreen_menubutton.get_popup().add_item("Full Screen")
	fullscreen_menubutton.get_popup().connect("id_pressed", self, "_on_item_pressed")

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
	
func _on_item_pressed(item_id):
	var item_name = fullscreen_menubutton.get_popup().get_item_text(item_id)
	fullscreen_menubutton.set_text(item_name)
	match item_name:
		"Windowed":
			print("Put windowed code here")
		"Full Screen":
			print("Put fullscreen code here")
