extends Node2D

@export var minion_limit: int = 50;
@export var soft_minion_limit: int = 35;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EntityGroups.set_minions_ref(self);
	EventBus.minion_spawn.connect(self.on_attempt_spawn);

func on_attempt_spawn(event: EntitySpawnEvent) -> void:
	if self.get_child_count() >= minion_limit:
		event.set_canceled(true);
		return;
	var minion_limits_diff: float = self.minion_limit - self.soft_minion_limit;
	var spawn_cancel_chance: float = (self.get_child_count() - soft_minion_limit) as float / minion_limits_diff;
	spawn_cancel_chance = sqrt(max(spawn_cancel_chance, 0));
	var random_float: float = randf();
	if !(random_float > spawn_cancel_chance):
		event.set_canceled(true);
