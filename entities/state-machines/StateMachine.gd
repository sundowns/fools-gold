extends Node
class_name StateMachine

#https://gdscript.com/godot-state-machine
# TODO: consider capping the size of the history buffer

var history = []
var state: Object
onready var parent = get_parent()
var is_awake: bool = true

signal state_changed(new_state)

func _ready():
	state = get_child(0)
	_enter_state()

func _change_to(new_state):
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()

func exit_and_change_to(new_state):
	history.append(state.name)
	state.exit(parent, new_state)

func back():
	if history.size() > 0:
		state.exit(parent, history.pop_back())

func _enter_state():
	# Give the new state a reference to this state machine script
	emit_signal("state_changed", state.name)
	state.fsm = self
	state.enter(parent)

# Route Game Loop function calls to
# current state handler method if it exists
func _process(delta):
	if is_awake and state.has_method("process"):
		state.process(parent, delta)

func _physics_process(delta):
	if is_awake and state.has_method("physics_process"):
		state.physics_process(parent, delta)

func _input(event):
	if is_awake and state.has_method("input"):
		state.input(parent, event)

func _unhandled_input(event):
	if is_awake and state.has_method("unhandled_input"):
		state.unhandled_input(parent, event)

func _unhandled_key_input(event):
	if is_awake and state.has_method("unhandled_key_input"):
		state.unhandled_key_input(parent, event)

func _notification(what):
	if state && state.has_method("notification"):
		state.notification(parent, what)

func alert(what: String, params: Dictionary = {}):
	if state and state.has_method(what):
		state.call(what, parent, params)
