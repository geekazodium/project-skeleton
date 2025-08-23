extends Resource
class_name StatusEffect

func get_effect_name() -> StringName:
	return "";

@warning_ignore("unused_parameter")
func update(entity: EntityBody, stacks: int) -> void:
	pass
