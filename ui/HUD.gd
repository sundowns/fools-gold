extends CanvasLayer

export(bool) var is_debug := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$DEBUG.visible = is_debug

func _on_player_state_updated(new_state: String):
	$DEBUG/PlayerState.text = new_state
