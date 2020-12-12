extends PathFollow

onready var enemy: Enemy = $Bandit


func _physics_process(delta):
	set_offset(offset + enemy.move_speed * delta)

func _ready():
#	enemy.connect("stopped_following", self, "on_stop_following")
	enemy.force_state("FollowPath")
#
#func on_stop_following():
#	set_physics_process(false)
