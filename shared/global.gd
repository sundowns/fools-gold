extends Node

const base_mouse_sens: float = 0.1
onready var mouse_sensitivity: float = base_mouse_sens
onready var sens_multiplier: float = 0.5 
onready var master_volume: float = 1.0

signal master_volume_changed(new_val)

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
	emit_signal("master_volume_changed", master_volume)
