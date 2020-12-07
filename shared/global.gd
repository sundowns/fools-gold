extends Node

const mouse_sensitivity = 0.05

var world_node: Spatial = null
var player_node: Player = null
var navigation_map: Navigation = null

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
