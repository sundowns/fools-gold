extends Spatial

# Initialise to spatial placeholder
onready var current_world = $WorldScenePlaceHolder
onready var beatz = $ANiceAssBeat

func _ready():
# warning-ignore:return_value_discarded
	LevelManager.connect("level_complete", self, "on_level_complete")
# warning-ignore:return_value_discarded
	LevelManager.connect("all_levels_complete", self, "on_game_complete")
# warning-ignore:return_value_discarded
	LevelManager.connect("level_restarted", self, "on_level_restarted")
	call_deferred("load_world", LevelManager.get_next_level())

func load_world(new_world_scene: PackedScene):
	# unload currently loaded world if it exists
	if current_world:
		remove_child(current_world)
		current_world.queue_free()
		current_world = null
	current_world = new_world_scene.instance()
	add_child(current_world)

func _process(_delta):
	if not beatz.is_playing():
		beatz.play()

func on_level_complete():
	var next_world = LevelManager.get_next_level()
	if next_world:
		call_deferred("load_world", next_world)

func on_level_restarted():
	call_deferred("load_world", LevelManager.get_current_level())

func on_game_complete():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ui/EndScreen.tscn")
