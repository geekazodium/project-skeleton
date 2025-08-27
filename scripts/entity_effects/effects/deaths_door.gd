extends StatusEffect
class_name DeathsDoor

@export var decay_rate_base: float = 0.1;

func get_effect_name() -> StringName:
	return "Death's Door";

func update(delta: float,status_tracker: StatusTracker, stacks: int) -> void:
	status_tracker.parent_body.modulate = status_tracker.parent_body.modulate.darkened(.5);
	var effective_delta: float = (
		delta * self.decay_rate_base
	);
	var decay_prob: float = 1.-pow(FollowCamera2D.EULER_CONST,-effective_delta);
	for i in range(stacks):
		if randf() < decay_prob:
			status_tracker.remove_stacks(self.get_effect_name(),1);

func on_final_remove(entity_body: EntityBody, _stacks: int) -> void:
	entity_body.modulate = Color.WHITE;
