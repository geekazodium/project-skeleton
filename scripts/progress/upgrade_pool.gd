extends Node

@export var upgrade_pool: Dictionary = {};
@export var unavailable_upgrades_pool: Dictionary = {};
@export var minions: Node2D = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_up.connect(self.on_level_up);

func on_level_up(event: LevelUpEvent):
	self.move_availibility();
	
	var _level: int = event.get_level();
	var pool = upgrade_pool.values();
	pool.shuffle();
	var upgrades: Array[UpgradeStrategy] = [];
	upgrades.assign(pool.slice(0,3));
	
	for upgrade in upgrades:
		upgrade.set_minions(self.minions);
	
	event.set_upgrade_options(upgrades);

func move_availibility():
	for key in self.unavailable_upgrades_pool.keys():
		var value = self.unavailable_upgrades_pool.get(key) as UpgradeStrategy;
		if value.prerequisites_met(self.upgrade_pool):
			self.upgrade_pool[key] = value;
			self.unavailable_upgrades_pool.erase(key);
