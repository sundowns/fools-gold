extends RigidBody

export(float) var impulse_magnitude := 10.0
var has_cligged := false

func _ready():
	set_as_toplevel(true)
	var direction = Vector3.UP 
	apply_central_impulse(direction * impulse_magnitude)

func _on_Timer_timeout():
	queue_free()

func _on_ShotgunShell_body_entered(_body):
	if has_cligged:
		return
	$DropAudio.play()
	has_cligged = true
