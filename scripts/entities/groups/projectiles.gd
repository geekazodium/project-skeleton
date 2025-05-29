extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EntityGroups.set_projectiles_ref(self);
