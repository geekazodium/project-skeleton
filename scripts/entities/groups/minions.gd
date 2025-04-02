extends Node2D

@export var minion_limit: int = 50;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EntityGroups.set_minions_ref(self);
	EventBus.minion_spawn.connect(self.on_attempt_spawn);

func on_attempt_spawn(event: EntitySpawnEvent):
	if self.get_child_count() >= minion_limit:
		event.set_canceled(true);
