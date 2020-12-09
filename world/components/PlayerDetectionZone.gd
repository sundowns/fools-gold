extends Area
class_name PlayerDetectionZone

export(bool) var is_active := true
export(float) var wake_up_delay := 0.0
export(float) var activation_delay := 0.0

onready var wakeup_delay_timer: Timer = $WakeUpTimer
onready var activation_delay_timer: Timer = $ActivationDelayTimer

signal triggered

func _ready():
	if wake_up_delay > 0.0:
		is_active = false
		wakeup_delay_timer.start(wake_up_delay)
	else:
		set_deferred('monitoring', is_active)

func deactivate():
	is_active = false
	set_deferred('monitoring', false)

func activate():
	is_active = true
	monitoring = true

func broadcast():
	emit_signal("triggered")

func _on_WakeUpTimer_timeout():
	activate()

func _on_ActivationDelayTimer_timeout():
	broadcast()
	is_active = false
	activation_delay_timer.stop()
