extends Entity
class_name Enemy

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var action_animation_player: AnimationPlayer = $ActionAnimationPlayer
onready var death_effect_scene: PackedScene = preload("res://effects/EnemyDeathEffect.tscn")
onready var state_machine: StateMachine = $StateMachine
onready var player_navigate_detection_zone: Area = $PlayerNavigateToPlayerDetectionZone
onready var attack_cooldown: Timer = $AttackCooldown
onready var check_for_los_timer: Timer = $LosCheckTimer
onready var hurt_sound: AudioStreamPlayer3D = $HurtSound
onready var death_sound: AudioStreamPlayer3D = $DeathSound

var can_attack := true
var path := []
var path_index := 0
var has_los_to_player := true
var queued_for_death = false # Used to avoid dying multiple times in one frame

export(float) var move_speed := 9.0
export(int, LAYERS_3D_PHYSICS) var los_collision_mask

func _ready():
# warning-ignore:return_value_discarded
	connect("dead", self, "_on_death")
# warning-ignore:return_value_discarded
	connect("hurt", self, "_on_hurt")
# warning-ignore:return_value_discarded
	player_navigate_detection_zone.connect("body_entered", self, "_on_PlayerChaseDetectionZone_body_entered")
# warning-ignore:return_value_discarded
	attack_cooldown.connect("timeout", self, "reset_attack")
# warning-ignore:return_value_discarded
	check_for_los_timer.connect("timeout", self, "calculate_los_to_player")

func _physics_process(_delta):
	if Global.player_node:
		look_at(Vector3(Global.player_node.global_transform.origin.x, global_transform.origin.y, Global.player_node.global_transform.origin.z), Vector3.UP)

func apply_movement():
	var movement = Vector3.ZERO
	movement.z = velocity.z + gravity_vector.z
	movement.x = velocity.x + gravity_vector.x
	movement.y = velocity.y + gravity_vector.y
# warning-ignore:return_value_discarded
	move_and_slide(movement, Vector3.UP)

# warning-ignore:unused_argument
func on_gun_hit(damage: float, knockback: Vector3, is_headshot: bool):
	# TODO: some check to see if we're already aggro'd (so we cant be long distance cheesed)
	.update_health(-damage)
	.push(knockback)
	animation_player.play("Hurt")

func _on_death():
	if !queued_for_death:
		queued_for_death = true
		play_death_sound()
		spawn_death_particles()
		queue_free()

func _on_hurt(_val):
	hurt_sound.play()

func play_death_sound():
	remove_child(death_sound)
# warning-ignore:return_value_discarded
	death_sound.connect("finished", death_sound, "queue_free")
	Global.world_node.add_child(death_sound)
	death_sound.global_transform.origin = global_transform.origin
	death_sound.play()

func spawn_death_particles():
	var new_particles = death_effect_scene.instance()
	Global.world_node.add_effect(new_particles)
	new_particles.global_transform.origin = global_transform.origin

func _on_PlayerChaseDetectionZone_body_entered(body):
	state_machine.alert("entered_sight_range", {body = body})

func reset_path():
	path = []
	path_index = 0

func calculate_path_to_player():
	assert(Global.player_node and Global.navigation_map, "Missing player_node or nav_map globals..")
	var target_position = Global.player_node.global_transform.origin
	path = Global.navigation_map.get_simple_path(global_transform.origin, target_position)
	path_index = 0

func calculate_los_to_player():
	assert(Global.player_node, "Missing player_node in globals")
	var raycast_impact := get_world().direct_space_state.intersect_ray(global_transform.origin, Global.player_node.global_transform.origin, [self], los_collision_mask)
	if raycast_impact:
		if raycast_impact.collider is Player:
			has_los_to_player = true
		else:
			has_los_to_player = false
	else:
		has_los_to_player = false
	check_for_los_timer.start()

# Sets velocity towards the next point in the path. Returns whether the path is still valid or not (more left to follow)
func follow_path() -> bool:
	# Move along the path if it exists (just sets a velocity towards next point)
	if path_index < path.size():
		var next_point = path[path_index]
		var to_next_point = next_point - global_transform.origin
		if to_next_point.length() < 3:
			# We've reached the next navigation node, check if we can see player!
			path_index += 1
			return true
		else:
			velocity = to_next_point.normalized() * move_speed
			return true
	else:
		return false

func reset_attack():
	can_attack = true

func check_if_player_in_PlayerChaseDetectionZone() -> bool:
	if not player_navigate_detection_zone:
		return false
	var we_got_em = false
	for body in player_navigate_detection_zone.get_overlapping_bodies():
		we_got_em = true
	return we_got_em
