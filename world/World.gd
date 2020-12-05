extends Spatial

onready var spawn_point: Position3D = $PlayerSpawnPoint
onready var effects: Node = $Effects

func _ready():
	var player = spawn_player()
	player.call_deferred("initialise")

func spawn_player():
	var player = load("res://entities/Player.tscn").instance()
	add_child(player)
	player.global_transform = spawn_point.global_transform
	return player

func add_effect(instanced_scene: Node):
	effects.add_child(instanced_scene)
