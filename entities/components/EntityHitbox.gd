extends Area
class_name EntityHitbox

export(NodePath) var owning_entity_path: NodePath
var owning_entity: Node = null

func _ready():
	assert(owning_entity_path != null, "Tried to initialise un-owned hitbox :{")
	owning_entity = get_node(owning_entity_path)
	assert(owning_entity != null, "ur stupid")
