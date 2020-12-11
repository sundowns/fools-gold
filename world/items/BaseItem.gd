extends Spatial

export(String) var item_key = "revolver"

onready var animation_player: AnimationPlayer = $AnimationPlayer

export(float) var health_value := 0.0

func _ready():
	animation_player.play("Default")

func player_grabbed():
	if item_key != "health":
		WeaponUnlocks.unlock(item_key)
	elif Global.player_node:
		Global.player_node._on_health_pickup(health_value)
	queue_free()

func _on_PlayerEnterTriggerZone_triggered():
	player_grabbed()
