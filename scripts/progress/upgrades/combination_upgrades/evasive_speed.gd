extends UpgradeStrategy

@export var chance_per_level: float = .05;

func _ready():
	EventBus.enemy_dealt_damage.connect(self.on_enemy_dealt_damage);

func on_enemy_dealt_damage(event: EntityDealDamageEvent):
	var bonus_chance = 1 - pow(1 - self.chance_per_level, self.level);
	if randf() < bonus_chance:
		event.set_canceled(true);

func prerequisites_met(pool: Dictionary) -> bool:
	return pool.get("Minion Speed").level >= 1 && pool.get("Minion Attack Speed").level >= 1;
