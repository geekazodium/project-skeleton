extends Node

const default_save_path: String = "user://save_state.tres"

var _save_state_instance: SaveStateInstance = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if ResourceLoader.exists(default_save_path):
		self._save_state_instance = ResourceLoader.load(default_save_path) as SaveStateInstance;
	else:
		self._save_state_instance = SaveStateInstance.new();
		print("no user save state found, generating new save state");
		ResourceSaver.save(self._save_state_instance, default_save_path);

func get_flag(key: StringName, default: bool = false) -> bool:
	if !self._save_state_instance.flags.has(key):
		return default;
	return self._save_state_instance.flags[key];

func set_flag(key: StringName, value: bool):
	self._save_state_instance.flags[key] = value;
	ResourceSaver.save(self._save_state_instance, default_save_path);
