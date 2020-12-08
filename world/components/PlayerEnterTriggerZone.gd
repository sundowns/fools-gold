extends Area

export(bool) var one_shot := true
export(bool) var is_active := true
export(float) var wake_up_delay := 0.0
export(float) var activation_delay := 0.0

onready var wakeup_delay_timer: Timer = $WakeUpTimer
onready var activation_delay_timer: Timer = $ActivationDelayTimer

signal triggered

var is_triggered := false

func _ready():
	if wake_up_delay > 0.0:
		is_active = false
		wakeup_delay_timer.start(wake_up_delay)
	else:
		set_deferred('monitoring', is_active)

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

func deactivate():
	is_active = false
	set_deferred('monitoring', false)

func activate():
	is_active = true
	set_deferred('monitoring', true)
	# Check if player is already inside the zone
	for body in get_overlapping_bodies():
		trigger()
		break

func broadcast():
	emit_signal("triggered")

func _on_PlayerEnterTriggerZone_body_entered(_body):
	trigger()

func _on_WakeUpTimer_timeout():
	activate()
