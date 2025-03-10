extends UpgradeStrategy

@export var increase_per_level: float = 1;

func _ready():
	EventBus.minion_spawn.connect(self.on_minion_spawn);

func on_minion_spawn(event: EntitySpawnEvent):
	var health_tracker: HealthTracker = event.get_entity().get_node(HealthTracker.default_path);
	health_tracker.add_max_health(self.increase_per_level * self.level);
