extends Entity
class_name Enemy

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var death_effect_scene: PackedScene = preload("res://effects/EnemyDeathEffect.tscn")

func _ready():
# warning-ignore:return_value_discarded
	connect("dead", self, "_on_death")

func _physics_process(delta):
	if Global.player_node:
		look_at(Vector3(Global.player_node.global_transform.origin.x, global_transform.origin.y, Global.player_node.global_transform.origin.z), Vector3.UP)

# warning-ignore:unused_argument
func on_gun_hit(damage: float, knockback: Vector3, is_headshot: bool):
	.update_health(-damage)
	.push(knockback)
	animation_player.play("Hurt")

func _on_death():
	spawn_death_particles()
	queue_free()

func spawn_death_particles():
	var new_particles = death_effect_scene.instance()
	Global.world_node.add_effect(new_particles)
	new_particles.global_transform.origin = global_transform.origin
