extends Node
class_name InstantiateOnExit

@export var scene: PackedScene = null;

func _instantiate(to_replace: Node2D):
	var new_inst: Node2D = scene.instantiate();
	new_inst.global_position = to_replace.global_position;
	to_replace.get_parent().add_child(new_inst);
