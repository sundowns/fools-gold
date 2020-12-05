extends Node
class_name Gun

onready var cooldown_timer: Timer = $Cooldown

export(float) var cooldown: float = 0.5
export(float) var damage: float = 1.0
export(float) var knockback_magnitude: float = 1.0

var is_ready := true

func _ready():
	cooldown_timer.connect("timeout", self, "_on_cooldown_finish") #TODO: test

func gun_fired():
	is_ready = false
	cooldown_timer.start()
	# TODO: use a timer here for cooldown

func shoot(_aim_cast: RayCast, _camera_origin: Vector3):
	pass

func _on_cooldown_finish():
	is_ready = true
