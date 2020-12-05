extends Gun

export(float) var headshot_damage_modifier = 1.5

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	var contact_position: Vector3 = aim_cast.get_collision_point()
	var entity_hit = aim_cast.get_collider()
	if entity_hit is EntityHitbox:
		var owning_entity = entity_hit.owning_entity
		var real_damage = damage
		if entity_hit.is_headshot:
			real_damage = real_damage * headshot_damage_modifier
		owning_entity.on_gun_hit(damage, calculate_knockback(camera_origin, contact_position), entity_hit.is_headshot)
#	else: # TODO: add a 'world-hit' effect by calling world.add_effect here
	.gun_fired()

func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude
