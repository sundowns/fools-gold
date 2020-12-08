extends Enemy
class_name Bandit

export(float) var start_attacking_distance := 12.0
export(float) var attack_damage := 10.0
export(float) var knockback_force := 20.0

func _ready():
	animation_player.play("Default")

func check_if_player_attackable() -> bool:
	if not Global.player_node:
		return false
	if not has_los_to_player:
		return false
	return global_transform.origin.distance_to(Global.player_node.global_transform.origin) <= start_attacking_distance

func run_at_player():
	if not Global.player_node:
		return
	var direction_to_player = (Global.player_node.global_transform.origin - global_transform.origin).normalized()
	velocity = direction_to_player * move_speed

func swing_at_the_cunt():
	if not can_attack:
		return
	action_animation_player.play("Attack")
	can_attack = false
	attack_cooldown.start()

func _on_AttackHitbox_body_entered(body):
	var knockback_direction = (Global.player_node.global_transform.origin - global_transform.origin).normalized()
	body.hit_by_bandit(attack_damage, knockback_force * knockback_direction)
