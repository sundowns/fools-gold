extends PlayerDetectionZone

export(float) var polling_interval := 3.0

onready var polling_timer: Timer = $PollingTimer

func _ready():
	if is_active:
		polling_timer.start(polling_interval)

func activate():
	polling_timer.start(polling_interval)

func deactivate():
	polling_timer.stop()

func poll():
	for body in get_overlapping_bodies():
		broadcast()
		break

func _on_PollingTimer_timeout():
	poll()
