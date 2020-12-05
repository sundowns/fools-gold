extends Camera

export var camera_path: NodePath
var camera: Camera

func _ready():
	camera = get_node(camera_path)

func _process(_delta):
	global_transform = camera.global_transform
