extends UpgradeStrategy

var death_condition: StringName;

func _ready():
	self.death_condition = DeathsDoor.new().get_effect_name();
	EventBus.minion_dead.connect(self.on_minion_dead);

func on_minion_dead(event: EntityDeathEvent) -> void:
	var status_tracker: StatusTracker = StatusTracker.get_status_tracker(event.get_entity());
	if status_tracker.get_stacks(self.death_condition) < self.level:
		status_tracker.add_stacks(self.death_condition,1);
		event.set_canceled(true);
		var health_tracker: HealthTracker = HealthTracker.get_health_tracker(event.get_entity());
		health_tracker.change_health(-health_tracker.health + 1);
