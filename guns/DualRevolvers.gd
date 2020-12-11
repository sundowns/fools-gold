extends Gun

onready var hit_particle_scene: PackedScene = preload("res://effects/BulletHitEffect.tscn")
onready var blood_hit_particle_scene: PackedScene = preload("res://effects/FleshyBulletHitEffect.tscn")
onready var headshot_hit_particle_scene: PackedScene = preload("res://effects/BigFleshyBulletHitEffect.tscn")

export(float) var headshot_damage_modifier = 1.5

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	if current_ammo <= 0:
		handle_no_ammo()
		return
	else:
		current_ammo -= 1
	
	var contact_position: Vector3 = aim_cast.get_collision_point()
	var entity_hit = aim_cast.get_collider()
	var knockback_force = calculate_knockback(camera_origin, contact_position)
	if entity_hit is EntityHitbox:
		var owning_entity = entity_hit.owning_entity
		var real_damage = damage
		if entity_hit.is_headshot:
			real_damage = real_damage * headshot_damage_modifier
		owning_entity.on_gun_hit(real_damage, knockback_force, entity_hit.is_headshot)
		spawn_hit_particles(contact_position, true, entity_hit.is_headshot)
	else:
		spawn_hit_particles(contact_position, false)
		if entity_hit is Prop:
			entity_hit.apply_impulse(entity_hit.to_local(contact_position), knockback_force)
	var animation_name = "FireLeft"
	if current_ammo % 2 == 0:
		animation_name = "FireRight"
	.gun_fired(animation_name)

func handle_no_ammo():
	# TODO: play clicking/no ammo sound
	.start_reload()

func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude

func spawn_hit_particles(position: Vector3, use_bloody_effect: bool, is_headshot: bool = false):
	var new_hit_particles = null
	var new_hit_sound = null
	if use_bloody_effect:
		new_hit_sound = $FleshHitAudio.duplicate()
		if is_headshot:
			new_hit_particles = headshot_hit_particle_scene.instance()
		else:
			new_hit_particles = blood_hit_particle_scene.instance()
	else:
		new_hit_particles = hit_particle_scene.instance()
		new_hit_sound = $WorldHitAudio.duplicate()
		
	Global.world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
	
	new_hit_particles.add_child(new_hit_sound)
	new_hit_sound.global_transform.origin = position
	new_hit_sound.play()
