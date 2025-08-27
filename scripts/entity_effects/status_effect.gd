extends Resource
class_name StatusEffect

func get_effect_name() -> StringName:
	return "";

@warning_ignore("unused_parameter")
func update(delta: float, status_tracker: StatusTracker, stacks: int) -> void:
	pass

@warning_ignore("unused_parameter")
func on_apply(entity: EntityBody, stacks: int) -> void:
	pass

@warning_ignore("unused_parameter")
func on_initial_apply(entity: EntityBody, stacks: int) -> void:
	pass

@warning_ignore("unused_parameter")
func on_remove(entity: EntityBody, stacks: int) -> void:
	pass

@warning_ignore("unused_parameter")
func on_final_remove(entity: EntityBody, stacks: int) -> void:
	pass
