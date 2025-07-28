extends UpgradeStrategy

@export var increase_per_level: float = 0.25;

func _ready():
	EventBus.minion_spawn.connect(self.on_minion_spawn);

func on_minion_spawn(event: EntitySpawnEvent):
	var health_tracker: HealthTracker = event.get_entity().get_node(HealthTracker.default_path);
	health_tracker.increase_per_second = self.increase_per_level * self.level;

func _level_change(change: int):
	var health_gain = self.increase_per_level * change;
	for minion: EntityBody in EntityGroups.get_minions():
		HealthTracker.get_health_tracker(minion).increase_per_second += health_gain;
