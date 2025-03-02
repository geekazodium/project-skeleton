extends Node2D
class_name StateMachine

@export var states: Dictionary = {};
@export var current_state: String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for k in states.keys():
		var state: Node = get_node(states.get(k));
		state.set_process(false);
		state.set_physics_process(false);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if self.current_state.length() == 0:
		return;
	var current_state:Node = get_node(states.get(self.current_state));
	current_state._physics_process(delta);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.current_state.length() == 0:
		return;
	var current_state:Node = get_node(states.get(self.current_state));
	current_state._process(delta);

# Call this method in a state node to check if node is the active state
static func is_active_state(_self: Node) -> bool:
	var state_machine: StateMachine = _self.get_node("../");
	return state_machine.get_node(state_machine.states.get(state_machine.current_state)) == _self;

static func switch_state(_self: Node, new_state: String):
	var state_machine: StateMachine = _self.get_node("../");
	state_machine.current_state = new_state;
