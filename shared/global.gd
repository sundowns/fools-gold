extends Node

const mouse_sensitivity = 0.05

var world_node: Node = null
var player_node: Node = null

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
