extends Spatial

onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_animation(index: String):
	animation_player.play(index)

func play_one():
	play_animation("1")

func play_two():
	play_animation("2")

func play_three():
	play_animation("3")
