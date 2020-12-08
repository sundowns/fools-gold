extends Node

const base_mouse_sens: float = 0.1
onready var mouse_sensitivity: float = base_mouse_sens
onready var sens_multiplier: float = 0.5 

onready var master_volume: float = 1.0
onready var music_volume: float = 1.0
onready var sfx_volume: float = 1.0

signal volume_changed(master_vol, sfx_vol, music_vol)

var world_node: Spatial = null
var player_node: Player = null
var navigation_map: Navigation = null

func _ready():
	mouse_sensitivity = sens_multiplier * base_mouse_sens

func _on_sensitivity_changed(value):
	sens_multiplier = value
	mouse_sensitivity = sens_multiplier * base_mouse_sens
	
func _on_master_volume_changed(value):
	master_volume = value
	emit_signal("volume_changed", master_volume, sfx_volume, music_volume)
	
func _on_music_volume_changed(value):
	music_volume = value
	emit_signal("volume_changed", master_volume, sfx_volume, music_volume)
	
func _on_sfx_volume_changed(value):
	sfx_volume = value
	emit_signal("volume_changed", master_volume, sfx_volume, music_volume)
