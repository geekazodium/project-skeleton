extends UpgradeStrategy

@export var reduction_per_level: float = .75;
@export var max_health_per_level: float = 10;
@export var health_per_second_per_level: float = 3;
var health_left: float = 0;

func _ready():
	EventBus.enemy_dealt_damage.connect(self.on_enemy_hit);
	EventBus.physics_processed.connect(self.on_tick);

func get_max_health() -> float:
	return self.max_health_per_level * self.level;

func get_health_per_second() -> float:
	return self.health_per_second_per_level * self.level;

func on_tick(delta: float) -> void:
	var max_health: float = self.get_max_health();
	if self.health_left < max_health:
		self.health_left = min(self.get_health_per_second() * delta + self.health_left, max_health);

func on_enemy_hit(event: EntityDealDamageEvent) -> void:
	if event.get_entity().collision_layer & 0b100 != 0:
		var reduction: float = self.reduction_per_level * self.level;
		reduction = min(self.health_left, reduction);
		event.add_damage(-reduction);
		print(self.health_left,",", reduction);
		self.health_left -= reduction;
