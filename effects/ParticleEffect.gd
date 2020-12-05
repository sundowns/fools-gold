extends Effect
class_name ParticleEffect

onready var particles: Particles = $Particles

func _ready():
	particles.emitting = true
