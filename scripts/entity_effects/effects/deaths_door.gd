extends StatusEffect
class_name DeathsDoor

@export var decay_rate_base: float = 0.1;

func get_effect_name() -> StringName:
	return "Death's Door";

func update(entity: EntityBody, stacks: int) -> void:
	entity.modulate = entity.modulate.darkened(.5);
