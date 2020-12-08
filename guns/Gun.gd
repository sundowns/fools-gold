extends Spatial
class_name Gun

onready var cooldown_timer: Timer = $Cooldown
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var mesh_location: Spatial = $MeshLocation
onready var fire_audio: AudioStreamPlayer3D = $FireAudio

export(float) var cooldown: float = 0.5
export(float) var damage: float = 1.0
export(float) var knockback_magnitude: float = 1.0

export(int) var ammo_per_reload = 6
var current_ammo: int

var is_ready := true
var is_reloading := false
var is_holstered := true

signal reloaded(new_ammo_count)
signal gun_holstered
signal gun_unholstered

func initialise():
# warning-ignore:return_value_discarded
	cooldown_timer.connect("timeout", self, "_on_cooldown_finish") 
	current_ammo = ammo_per_reload
# warning-ignore:return_value_discarded
	connect("gun_holstered", Global.player_node, "_on_gun_holstered")
# warning-ignore:return_value_discarded
	connect("gun_unholstered", Global.player_node, "_on_gun_unholstered")

func gun_fired():
	animation_player.play("Fire")
	fire_audio.play()
	is_ready = false
	cooldown_timer.start()
	# TODO: use a timer here for cooldown

func shoot(_aim_cast: RayCast, _camera_origin: Vector3):
	pass

func _on_cooldown_finish():
	is_ready = true
	if current_ammo <= 0:
		start_reload()

func start_reload():
	if current_ammo == ammo_per_reload:
		return
	animation_player.play("Reload")
	is_reloading = true

func reload():
	is_reloading = false
	current_ammo = ammo_per_reload
	emit_signal("reloaded", current_ammo)

func hide():
	mesh_location.visible = false
	
func show():
	mesh_location.visible = true
	
func holster():
	is_holstered = true
	animation_player.play("Holster")

func unholster():
	is_holstered = false
	animation_player.play("Unholster")

func emit_holster_status_update():
	if is_holstered:
		emit_signal("gun_holstered")
	else:
		is_ready = true
		emit_signal("gun_unholstered")
