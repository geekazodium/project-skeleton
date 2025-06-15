extends CanvasLayer

@export var visibility_parent: Control;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visibility_parent.visibility_changed.connect(self.on_parent_visibility_changed);
	self.on_parent_visibility_changed();

func on_parent_visibility_changed() -> void:
	self.visible = self.visibility_parent.is_visible_in_tree();
