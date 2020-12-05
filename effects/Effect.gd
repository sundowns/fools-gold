extends Spatial
class_name Effect

export(bool) var auto_remove := true
export(float) var remove_after := 1.0

onready var clear_timer: Timer = $ClearAfterTimer

func _ready():
	set_as_toplevel(true)
	clear_timer.connect("timeout", self, "_on_ClearAfterTimer_timeout")

func _on_ClearAfterTimer_timeout():
	print('kill effect')
	queue_free()
