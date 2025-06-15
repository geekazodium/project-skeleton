extends Button
class_name SwitchSceneButton

@export var next_scene: String;
@export var auto_grab_focus: bool = false;
@export var unpause: bool = false;

func _pressed() -> void:
	if self.unpause:
		self.get_tree().paused = false;
	self.get_tree().change_scene_to_file(next_scene);

func _ready() -> void:
	self.visibility_changed.connect(self.on_visibility_changed);

func on_visibility_changed() -> void:
	if self.is_visible_in_tree() && self.auto_grab_focus:
		self.grab_focus();
