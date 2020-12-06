extends CanvasLayer

export(bool) var is_debug := false

onready var ammo_label: Label = $AmmoLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	$DEBUG.visible = is_debug

func _on_player_state_updated(new_state: String):
	$DEBUG/PlayerState.text = new_state

func _on_player_ammo_updated(new_value: int):
	ammo_label.text = "Ammo: %d" % new_value
