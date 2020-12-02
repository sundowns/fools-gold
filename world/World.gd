extends Spatial

onready var spawn_point: Position3D = $PlayerSpawnPoint

func _ready():
	var player = spawn_player()
	player.call_deferred("initialise")

func spawn_player():
	var player = load("res://entities/Player.tscn").instance()
	add_child(player)
	player.global_transform = spawn_point.global_transform
	return player
