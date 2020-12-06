extends Spatial

onready var animation_player: AnimationPlayer = $AnimationPlayer

signal activated

var is_pressed := false
export(bool) var one_shot := true

func activate():
	if is_pressed and one_shot:
		return
	is_pressed = true
	animation_player.play("Button Press")

func on_button_press_animation_finished():
	emit_signal("activated")
	animation_player.play("Default")
