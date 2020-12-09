extends PlayerDetectionZone

export(bool) var one_shot := true

var is_triggered := false

func trigger():
	if not is_active:
		return
	if is_triggered and one_shot:
		return
	is_triggered = true
	if activation_delay > 0.0:
		activation_delay_timer.start(activation_delay)
	else:
		broadcast()
	if one_shot:
		deactivate()

func activate():
	# Check if player is already inside the zone
	for body in get_overlapping_bodies():
		trigger()
		break


func _on_PlayerEnterTriggerZone_body_entered(_body):
	trigger()
