extends Node
class_name StatusTracker

@export var parent_body: EntityBody;
var effects: Dictionary = {};

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	for k in effects.keys():
		StatusAffector.update(self.parent_body,k,effects.get(k));

func get_stacks(key: StringName) -> int:
	if !self.effects.has(key):
		return 0;
	return self.effects[key];

func add_stacks(key: StringName, amount: int) -> void:
	if !self.effects.has(key):
		self.effects[key] = amount;
	else:
		self.effects[key] += amount;

static var default_path: String = "StatusTracker";

static func get_status_tracker(entity: Node, path: String = default_path) -> StatusTracker:
	return entity.get_node(path);
