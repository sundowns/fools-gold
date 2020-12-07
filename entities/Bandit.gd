extends Enemy
class_name Bandit

export(float) var start_attacking_distance := 5.0

func _ready():
	animation_player.play("Default")

func check_if_player_attackable() -> bool:
	if not Global.player_node:
		return false
	return global_transform.origin.distance_to(Global.player_node.global_transform.origin) <= start_attacking_distance

func run_at_player():
	if not Global.player_node:
		return
	var direction_to_player = (Global.player_node.global_transform.origin - global_transform.origin).normalized()
	velocity = direction_to_player * move_speed

func _on_AttackHitbox_body_entered(body):
	print(body)
	print("I hit the player!!")
