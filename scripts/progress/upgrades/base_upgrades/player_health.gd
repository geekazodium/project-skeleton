extends UpgradeStrategy

@export var bonus_per_level: float = 10;

func _ready():
	pass

func _level_change(change: int):
	for player in EntityGroups.get_players():
		HealthTracker.get_health_tracker(player).add_max_health(self.bonus_per_level * change);
