extends UpgradeStrategy

@export var recovery_per_level: float = .5;

func _ready():
	EventBus.minion_dealt_damage.connect(self.on_minion_dealt_damage);

func on_minion_dealt_damage(event: EntityDealDamageEvent):
	var source_body: EntityBody = event.get_damage_source().get_parent();
	var recovery = 1 - pow(1 - self.recovery_per_level, self.level);
	event.add_multiplier(recovery);
	var health_tracker: HealthTracker = source_body.get_node(HealthTracker.default_path);
	health_tracker.change_health(recovery * event.get_damage());

func prerequisites_met(pool: Dictionary) -> bool:
	return pool.get("Minion Health").level >= 1 && pool.get("Minion Damage").level >= 1;
