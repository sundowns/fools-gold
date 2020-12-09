extends Gun

export var num_pellets: int = 8
export var spread_range: float = 70
export var is_pumped = true

onready var hit_particle_scene: PackedScene = preload("res://effects/BulletHitEffect.tscn")
onready var blood_hit_particle_scene: PackedScene = preload("res://effects/FleshyBulletHitEffect.tscn")
onready var shell_scene: PackedScene = preload("res://guns/ShotgunShell.tscn")
onready var shell_spawn_location: Position3D = $MeshLocation/ShellSpawnLocation
onready var rng = RandomNumberGenerator.new()

func _ready():
	$Shell.visible = false

func shoot(aim_cast: RayCast, camera_origin: Vector3):
	if !is_pumped:
		pump()
	else:
		is_pumped = false
		rng.randomize()
		if current_ammo <= 0:
			handle_no_ammo()
			return
		else:
			current_ammo -= 1
			
		for _pellet in range(num_pellets):
			var pellet_cast = aim_cast.duplicate()
			Global.player_node.camera.add_child(pellet_cast)
			pellet_cast.global_transform.origin = aim_cast.global_transform.origin

			var spread_x = rng.randfn(0, spread_range)
			var spread_y = rng.randfn(0, spread_range)
			pellet_cast.cast_to = aim_cast.cast_to + Vector3(spread_x, spread_y, 0)
			pellet_cast.force_raycast_update()
				
			var contact_position: Vector3 = pellet_cast.get_collision_point()
			var entity_hit = pellet_cast.get_collider()
			var knockback_force = calculate_knockback(camera_origin, contact_position)
			if entity_hit is EntityHitbox:
				var owning_entity = entity_hit.owning_entity
				owning_entity.on_gun_hit(damage, knockback_force, entity_hit.is_headshot)
				spawn_hit_particles(contact_position, true)
			else:
				spawn_hit_particles(contact_position, false)
				if entity_hit is Prop:
					entity_hit.apply_impulse(entity_hit.to_local(contact_position), knockback_force)
			pellet_cast.queue_free()
	
		.gun_fired()

func handle_no_ammo():
	# TODO: play clicking/no ammo sound
	.start_reload()
	
func reload_one():
	current_ammo += 1
	if current_ammo == ammo_per_reload:
		animation_player.play("Reload Finished")
	else:
		animation_player.play("Reload One")
	emit_signal("reloaded", current_ammo)
	
func reload_finished():
	is_reloading = false
	
func pump():
	animation_player.play("Pump")
	
func calculate_knockback(from: Vector3, to: Vector3) -> Vector3:
	return (to - from).normalized() * knockback_magnitude

func spawn_hit_particles(position: Vector3, use_bloody_effect: bool):
	var new_hit_particles = null
	var new_hit_sound = null
	if use_bloody_effect:
		new_hit_particles = blood_hit_particle_scene.instance()
		new_hit_sound = $FleshHitAudio.duplicate()
	else:
		new_hit_particles = hit_particle_scene.instance()
		new_hit_sound = $WorldHitAudio.duplicate()
	
	Global.world_node.add_effect(new_hit_particles)
	new_hit_particles.global_transform.origin = position
	
	new_hit_particles.add_child(new_hit_sound)
	new_hit_sound.global_transform.origin = position
	new_hit_sound.play()


func spawn_shell():
	var new_shell = shell_scene.instance()
	Global.world_node.add_effect(new_shell)
	new_shell.global_transform.origin = shell_spawn_location.global_transform.origin

func holster():
	var anim = animation_player.current_animation
	if  anim == "Pump" || anim == "Fire":
		animation_player.seek(0.0, true)
		animation_player.stop()
	is_holstered = true
	animation_player.play("Holster")


