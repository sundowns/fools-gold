extends Control

onready var fullscreen_menubutton = $FullScreen/MenuButton
onready var master_vol_slider = $MasterVolume/MasterVolSlider
onready var music_vol_slider = $MusicVolume/MusicVolSlider
onready var sfx_vol_slider = $SfxVolume/SfxVolSlider
onready var sens_slider = $Sensitivity/SensSlider

signal options_closed
signal sensitivity_changed(new_sens_multiplier)
signal master_volume_changed(new_volume)
signal music_volume_changed(new_volume)
signal sfx_volume_changed(new_volume)

var is_open = false

func _ready():
# warning-ignore:return_value_discarded
	connect("sensitivity_changed", Global, "_on_sensitivity_changed")
# warning-ignore:return_value_discarded
	connect("master_volume_changed", Global, "_on_master_volume_changed")
# warning-ignore:return_value_discarded
	connect("music_volume_changed", Global, "_on_music_volume_changed")
# warning-ignore:return_value_discarded
	connect("sfx_volume_changed", Global, "_on_sfx_volume_changed")
	master_vol_slider.value = Global.master_volume
	music_vol_slider.value = Global.music_volume
	sfx_vol_slider.value = Global.sfx_volume
	sens_slider.value = Global.sens_multiplier
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	fullscreen_menubutton.get_popup().add_item("Full Screen")
	fullscreen_menubutton.get_popup().add_item("Windowed")
	fullscreen_menubutton.get_popup().connect("id_pressed", self, "_on_item_pressed")

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if is_open:
			close_menu()

func open_menu():
	is_open = true
	self.visible = true

func close_menu():
	is_open = false
	self.visible = false
	emit_signal("options_closed")

func _on_BackButton_pressed():
	close_menu()
	
func _on_item_pressed(item_id):
	var item_name = fullscreen_menubutton.get_popup().get_item_text(item_id)
	fullscreen_menubutton.set_text(item_name)
	match item_name:
		"Windowed":
			OS.window_fullscreen = false
		"Full Screen":
			OS.window_fullscreen = true


func _on_MasterVolSlider_value_changed(value):
	emit_signal("master_volume_changed", value)


func _on_SensSlider_value_changed(value):
	emit_signal("sensitivity_changed", value)


func _on_MusicVolSlider_value_changed(value):
	emit_signal("music_volume_changed", value)


func _on_SfxVolSlider_value_changed(value):
	emit_signal("sfx_volume_changed", value)
