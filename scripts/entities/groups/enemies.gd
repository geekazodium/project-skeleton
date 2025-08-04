extends Node2D
class_name Enemies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EntityGroups.set_enemies_ref(self);
