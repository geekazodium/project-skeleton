extends UpgradeStrategy

@export var increase_per_level: float = 1;

func _ready() -> void:
	EventBus.minion_spawn.connect(self.on_minion_spawn);

func on_minion_spawn(event: EntitySpawnEvent) -> void:
	var entity_body: EntityBody = event.get_entity();
	entity_body.increase_move_speed(self.increase_per_level * self.level);

func _level_change(change: int) -> void:
	var speed_gain = self.increase_per_level * change;
	for minion: EntityBody in EntityGroups.get_minions():
		minion.increase_move_speed(speed_gain);
