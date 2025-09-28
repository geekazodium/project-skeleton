@tool
extends RichTextLabel
class_name AllCleanLabel

@export var maybe_empty_container: Container;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.visible = maybe_empty_container.get_child_count() == 0;
