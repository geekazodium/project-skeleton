extends UpgradeStrategy

@export var chance_per_level: float = .4;
@export var rush_force: float = 700;

func _ready():
	EventBus.minion_dealt_damage.connect(self.on_minion_damage);

func on_minion_damage(event: EntityDealDamageEvent):
	var damage_source: AttackArea = event.get_damage_source();
	var bonus_chance = 1 - pow(1 - self.chance_per_level, self.level);
	if randf() < bonus_chance:
		damage_source.damage_cooldown_timer = 0;
		var entity_body: EntityBody = damage_source.get_parent();
		entity_body.apply_knockback((entity_body.global_position - event.get_entity().global_position).normalized() * -rush_force);

func prerequisites_met(pool: Dictionary) -> bool:
	return pool.get("Minion Health").level >= 1 && pool.get("Minion Attack Speed").level >= 1;
