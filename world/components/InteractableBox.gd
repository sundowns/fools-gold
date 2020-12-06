extends Area

class_name InteractableHitbox

export(NodePath) var owning_entity_path: NodePath
var owning_entity: Node = null
export(String) var owner_activation_callback_fn: String = "activate"

func _ready():
	assert(owning_entity_path != null, "Tried to initialise un-owned hitbox :{")
	owning_entity = get_node(owning_entity_path)
	assert(owning_entity != null, "path for interactable object not resolving. Path: %s" % owning_entity_path)

func interact():
	owning_entity.call(owner_activation_callback_fn)
