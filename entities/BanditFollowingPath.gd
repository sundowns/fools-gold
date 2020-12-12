extends PathFollow

onready var enemy: Enemy = $Bandit
export(float) var starting_offset := 0.0

func _physics_process(delta):
	set_offset(offset + enemy.move_speed * delta)

func _ready():
	set_offset(starting_offset)
	enemy.force_state("FollowPath")
