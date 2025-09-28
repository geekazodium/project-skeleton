extends UpgradeStrategy

@export var bonus_per_level: float = 1;

func _ready() -> void:
	EventBus.minion_dealt_damage.connect(self.on_minion_damage);

func on_minion_damage(event: EntityDealDamageEvent) -> void:
	event.add_damage(self.level * bonus_per_level);
