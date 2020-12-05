extends Entity
class_name Enemy

var player_node: Player

func _ready():
	connect("dead", self, "_on_death")

func _physics_process(delta):
	apply_gravity(delta)
	apply_movement()
	
	if player_node:
		look_at(Vector3(player_node.global_transform.origin.x, global_transform.origin.y, player_node.global_transform.origin.z), Vector3.UP)

func _process(_delta):
	# This is kinda trash but probably good enough...
	if player_node == null:
		player_node = get_tree().current_scene.find_node("Player", true, false)

func on_gun_hit(damage: float, knockback: Vector3):
	.update_health(-damage)
	.push(knockback)

func _on_death():
	queue_free() #TODO: death anim
