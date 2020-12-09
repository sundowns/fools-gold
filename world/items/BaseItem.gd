extends Spatial

export(String) var weapon_key = "revolver"

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	animation_player.play("Default")

func player_grabbed():
	WeaponUnlocks.unlock(weapon_key)
	queue_free()

func _on_PlayerEnterTriggerZone_triggered():
	player_grabbed()
