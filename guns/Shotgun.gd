extends Gun

onready var hit_particle_scene: PackedScene = preload("res://effects/BulletHitEffect.tscn")
onready var blood_hit_particle_scene: PackedScene = preload("res://effects/FleshyBulletHitEffect.tscn")

func shoot(_aim_cast: RayCast, _camera_origin: Vector3):
	print('shotgun go boom!!')
	.gun_fired()
	# TODO: shoot a bunch of slightly randomised raycasts out (8 pellets?)

func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude

func spawn_hit_particles(position: Vector3, use_bloody_effect: bool):
	var new_hit_particles = null
	if use_bloody_effect:
		new_hit_particles = blood_hit_particle_scene.instance()
	else:
		new_hit_particles = hit_particle_scene.instance()
		
	Global.world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
