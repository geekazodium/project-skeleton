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
		StatusAffector.emit_effect_first_added(self.parent_body, key, amount);
	else:
		self.effects[key] += amount;
		StatusAffector.emit_effect_added(self.parent_body, key, effects.get(key));

func remove_stacks(key: StringName, amount: int) -> void:
	var pre_remove: int = self.effects[key];
	if self.effects.has(key):
		self.effects[key] -= amount;
		if self.effects[key] <= 0:
			self.effects.erase(key);
			StatusAffector.emit_effect_final_removed(self.parent_body,key,pre_remove);
		else:
			StatusAffector.emit_effect_removed(self.parent_body,key,pre_remove);
static var default_path: String = "StatusTracker";

static func get_status_tracker(entity: Node, path: String = default_path) -> StatusTracker:
	return entity.get_node(path);
