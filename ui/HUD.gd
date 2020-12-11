extends CanvasLayer

export(bool) var is_debug := false

onready var ammo_label: Label = $AmmoRect/AmmoLabel
onready var health_label: Label = $HealthRect/HealthLabel
onready var interact_prompt: Label = $InteractPrompt
onready var crosshair = $CenterContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	$DEBUG.visible = is_debug
	interact_prompt.visible = false

func _on_player_state_updated(new_state: String):
	$DEBUG/PlayerState.text = new_state

func _on_player_ammo_updated(new_value: int):
	ammo_label.text = "%d" % new_value
	
func _on_player_health_updated(new_value: int):
	health_label.text = "%d%%" % new_value
	#nice and hardcoded max health fuck you
	
func _on_interaction_highlight_update(is_highlighting: bool):
	interact_prompt.visible = is_highlighting
