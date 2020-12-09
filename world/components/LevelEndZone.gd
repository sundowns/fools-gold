extends Area

export(bool) var is_active := true

func activate():
	is_active = true
	for body in get_overlapping_bodies():
		broadcast()
		break

func _on_LevelEndZone_body_entered(_body):
	if is_active:
		broadcast()

func broadcast():
	LevelManager.level_completed()
