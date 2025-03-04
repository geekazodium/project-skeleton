extends Node
class_name InstantiateOnExit

@export var scene: PackedScene = null;

func _instantiate(event: EntityDeathEvent):
	var new_inst: Node2D = scene.instantiate();
	var to_replace: Node2D = event.get_entity();
	new_inst.global_position = to_replace.global_position;
	to_replace.get_parent().add_child(new_inst);
