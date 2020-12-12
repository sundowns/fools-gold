extends Spatial

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var tween: Tween = $Tween
onready var pickup_effect_scene = preload("res://effects/PickupIdolEffect.tscn")

signal activated

var is_pressed := false
export(bool) var one_shot := true

func _ready():
	animation_player.play("Default")

func activate():
	if is_pressed and one_shot:
		return
	is_pressed = true
	emit_signal("activated")
	$InteractableHitbox.queue_free()
	animation_player.play("Pickup")
	
# warning-ignore:return_value_discarded
	tween.interpolate_property($OmniLight, "light_energy", 1.0, 0, 3.0, Tween.TRANS_CUBIC, Tween.EASE_OUT)
# warning-ignore:return_value_discarded
	tween.start()
	
	var new_effect = pickup_effect_scene.instance()
	Global.world_node.add_effect(new_effect)
	new_effect.global_transform.origin = global_transform.origin
	yield(get_tree().create_timer(3), "timeout")
	queue_free()
