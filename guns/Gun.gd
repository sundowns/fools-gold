extends Spatial
class_name Gun

onready var cooldown_timer: Timer = $Cooldown
onready var animation_player: AnimationPlayer = $AnimationPlayer

export(float) var cooldown: float = 0.5
export(float) var damage: float = 1.0
export(float) var knockback_magnitude: float = 1.0

export(int) var ammo_per_reload = 6
var current_ammo: int

var is_ready := true
var is_reloading := false

signal reloaded

func _ready():
	cooldown_timer.connect("timeout", self, "_on_cooldown_finish") 
	current_ammo = ammo_per_reload

func gun_fired():
	animation_player.play("Fire")
	is_ready = false
	cooldown_timer.start()
	# TODO: use a timer here for cooldown

func shoot(_aim_cast: RayCast, _camera_origin: Vector3):
	pass

func _on_cooldown_finish():
	is_ready = true

func start_reload():
	animation_player.play("Reload")
	is_reloading = true

func reload():
	is_reloading = false
	current_ammo = ammo_per_reload
	emit_signal("reloaded")
