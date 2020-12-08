extends Node

const base_mouse_sens: float = 0.1
onready var mouse_sensitivity: float = base_mouse_sens
onready var sens_multiplier: float = 0.5 

var world_node: Spatial = null
var player_node: Player = null
var navigation_map: Navigation = null

func _ready():
	mouse_sensitivity = sens_multiplier * base_mouse_sens

func _on_sensitivity_changed(value):
	sens_multiplier = value
	mouse_sensitivity = sens_multiplier * base_mouse_sens
