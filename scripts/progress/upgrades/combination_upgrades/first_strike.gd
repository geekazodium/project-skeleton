extends UpgradeStrategy

@export var area_increase_per_level: float = 200;

func _ready():
	EventBus.minion_spawn.connect(self.on_minion_spawn);

func on_minion_spawn(event: EntitySpawnEvent):
	var attack_area_shape: CollisionShape2D = event.get_entity().get_node("AttackArea/CollisionShape2D");
	attack_area_shape.scale *= 1 + sqrt(area_increase_per_level * self.level);

func _level_change(change: int):
	var health_gain = self.increase_per_level * change;
	for minion: EntityBody in self.get_minions():
		var attack_area_shape: CollisionShape2D = minion.get_node("AttackArea/CollisionShape2D");
		attack_area_shape.scale *= 1 + sqrt(area_increase_per_level * self.level);
