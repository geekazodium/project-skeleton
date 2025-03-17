extends UpgradeStrategy

@export var bonus_per_speed: float = .0005;
@export var reduction_per_speed: float = .002;
func _ready():
	EventBus.minion_dealt_damage.connect(self.on_minion_dealt_damage);
	EventBus.enemy_dealt_damage.connect(self.on_enemy_dealt_damage);

func on_minion_dealt_damage(event: EntityDealDamageEvent):
	var source_body: EntityBody = event.get_damage_source().get_parent();
	event.add_damage(source_body.velocity.length() * self.bonus_per_speed * self.level);

func on_enemy_dealt_damage(event: EntityDealDamageEvent):
	var entity_body: EntityBody = event.get_entity();
	var reduction = 1 - pow(1 - self.reduction_per_speed, self.level * entity_body.velocity.length());
	event.add_multiplier(-reduction);

func prerequisites_met(pool: Dictionary) -> bool:
	return pool.get("Minion Speed").level >= 1 && pool.get("Minion Damage").level >= 1;
