extends Gun

onready var hit_particle_scene: PackedScene = preload("res://effects/RevolverHitEffect.tscn")
var world_node: Node

func _ready():
	# Trash approach but w/e - fine for now.. Fix if it lags
	world_node = get_tree().current_scene.get_node("World")

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	# TODO: shoot a bunch of slightly randomised raycasts out (8 pellets?)
	pass
#	.gun_fired()


func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude

func spawn_hit_particles(position: Vector3):
	# TODO: do diff ones for hitting enemies vs world
	var new_hit_particles = hit_particle_scene.instance()
	world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
