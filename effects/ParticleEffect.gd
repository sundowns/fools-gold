extends Effect
class_name ParticleEffect

onready var particles: Particles = $Particles
onready var sound: AudioStreamPlayer3D = null

func _ready():
	particles.emitting = true
		
