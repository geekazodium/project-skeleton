extends UpgradeStrategy

@export var increase_per_level: float = 1.5;
@export var damage_per_level: float = 2;

func _ready():
	EventBus.minion_spawn.connect(self.on_minion_spawn);
	EventBus.minion_dealt_damage.connect(self.on_minion_hit);

func on_minion_spawn(event: EntitySpawnEvent):
	var health_tracker: HealthTracker = event.get_entity().get_node(HealthTracker.default_path);
	health_tracker.increase_per_second = self.increase_per_level * self.level;

func _level_change(change: int):
	var health_gain = self.increase_per_level * change;
	for minion: EntityBody in EntityGroups.get_minions():
		HealthTracker.get_health_tracker(minion).increase_per_second += health_gain;

func on_minion_hit(event: EntityDealDamageEvent) -> void:
	event.add_damage(self.damage_per_level * self.level);
	HealthTracker.get_health_tracker(event.get_damage_source().get_parent()).change_health(self.increase_per_level * self.level);
