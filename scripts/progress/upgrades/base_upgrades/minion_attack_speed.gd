extends UpgradeStrategy

@export var bonus_speed_per_level: float = .5;

func _ready() -> void:
	EventBus.minion_dealt_damage.connect(self.on_minion_damage);

func on_minion_damage(event: EntityDealDamageEvent) -> void:
	var damage_source: AttackArea = event.get_damage_source();
	damage_source.damage_cooldown_timer /= 1 + bonus_speed_per_level * self.level;
