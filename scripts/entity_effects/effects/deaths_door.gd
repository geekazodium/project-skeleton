extends StatusEffect
class_name DeathsDoor

func get_effect_name() -> StringName:
	return "Death's Door";

func update(entity: EntityBody, stacks: int) -> void:
	entity.modulate = entity.modulate.darkened(.5);
