extends Spatial

func _ready():
	$Particles.emitting = true
	$Audio3D.play()

func _on_Timer_timeout():
	queue_free()
