extends "res://effects/ParticleEffect.gd"

onready var blood_hit_particle_scene: PackedScene = preload("res://effects/FleshyBulletHitEffect.tscn")

var world_node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	world_node = get_tree().current_scene.get_node("World")


func spawn_hit_particles(position: Vector3, use_bloody_effect: bool):
	var new_hit_particles = null
	if use_bloody_effect:
		new_hit_particles = blood_hit_particle_scene.instance()
	else:
		new_hit_particles = hit_particle_scene.instance()
		
	world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
