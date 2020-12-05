extends Gun

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	var contact_position: Vector3 = aim_cast.get_collision_point()
	var entity_hit = aim_cast.get_collider()
	if entity_hit is EntityHitbox:
		print('fug')
	print(entity_hit)
	
	.gun_fired()
	print('pew pew!!')
