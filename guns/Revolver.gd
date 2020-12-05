extends Gun

onready var hit_particle_scene: PackedScene = preload("res://effects/RevolverHitEffect.tscn")

export(float) var headshot_damage_modifier = 1.5

var world_node: Node

func _ready():
	# Trash approach but w/e - fine for now.. Fix if it lags
	world_node = get_tree().current_scene.find_node("World", true, false)

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	var contact_position: Vector3 = aim_cast.get_collision_point()
	var entity_hit = aim_cast.get_collider()
	if entity_hit is EntityHitbox:
		var owning_entity = entity_hit.owning_entity
		var real_damage = damage
		if entity_hit.is_headshot:
			real_damage = real_damage * headshot_damage_modifier
		owning_entity.on_gun_hit(damage, calculate_knockback(camera_origin, contact_position), entity_hit.is_headshot)
	spawn_hit_particles(contact_position)

	.gun_fired()

func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude

func spawn_hit_particles(position: Vector3):
	# TODO: do diff ones for hitting enemies vs world
	var new_hit_particles = hit_particle_scene.instance()
	world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
