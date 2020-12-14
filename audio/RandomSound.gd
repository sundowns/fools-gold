extends Spatial
class_name RandomSound

onready var rng = RandomNumberGenerator.new()

func _ready():
	for child in get_children():
		assert(child is AudioStreamPlayer3D or child is AudioStreamPlayer, "RandomSound has non-audio player children")

func play():
	get_child(rng.randi_range(0, get_child_count() -1)).play()
