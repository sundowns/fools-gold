extends Spatial

# Modified from https://gist.github.com/HungryProton/c7adac9847d6fb0d6e9c0eb1b2c63ae1

var _materials := []
var _count := 0

func _ready() -> void:
	_find_all_materials("res://")
	for material_path in _materials:
		var loaded_resource = load(material_path)
		if loaded_resource is ParticlesMaterial:
			_create_particles_with(loaded_resource, material_path)
		elif loaded_resource is ShaderMaterial or loaded_resource is SpatialMaterial:
			_create_mesh_with(loaded_resource, material_path)
	set_process(true)


func _process(_delta: float) -> void:
	_count += 1
	if _count > 10:
		set_visible(false)
		set_process(false)


func _find_all_materials(path) -> void:
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	var path_root = dir.get_current_dir() + "/"

	while true:
		var file = dir.get_next()
		if file == "":
			break
		if dir.current_is_dir():
			_find_all_materials(path_root + file)
			continue
		if not file.ends_with(".tres"):
			continue
		_materials.append(path_root + file)
	dir.list_dir_end()


func _create_mesh_with(material: Material, path: String) -> void:
	var mesh = PlaneMesh.new()
	var mesh_instance = MeshInstance.new()
	add_child(mesh_instance)

	mesh.set_size(Vector2.ONE)
	mesh.set_material(material)
	mesh_instance.set_mesh(mesh)
	mesh_instance.rotation_degrees = Vector3(90, 0.0, 0.0)
	mesh_instance.set_name(path.get_file().split(".")[0])


func _create_particles_with(material: ParticlesMaterial, path: String) -> void:
	var particles = Particles.new()
	var mesh = PlaneMesh.new()
	add_child(particles)

	mesh.set_size(Vector2.ONE)
	particles.process_material = material
	particles.draw_passes = 1
	particles.draw_pass_1 = mesh
	particles.emitting = true
	particles.one_shot = false
	particles.set_name(path.get_file().split(".")[0])

