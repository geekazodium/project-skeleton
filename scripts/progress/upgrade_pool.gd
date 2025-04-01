extends Node
class_name UpgradePool

#@export var special_upgrade_pool: Dictionary = {};

var upgrade_get_order: Array[String] = [];
@export var upgrade_pool: Dictionary = {};
@export var minions: Node2D = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_up.connect(self.on_level_up);
	EventBus.powerup_selected.connect(self.on_powerup_selected);

func on_level_up(event: LevelUpEvent):
	var _level: int = event.get_level();
	var pool = upgrade_pool.values();
	pool.shuffle();
	var upgrades: Array[UpgradeStrategy] = [];
	upgrades.assign(pool.slice(0,3));
	
	for upgrade in upgrades:
		upgrade.set_minions(self.minions);
	
	event.set_upgrade_options(upgrades);

func on_powerup_selected(event: PowerUpSelectedEvent):
	upgrade_get_order.append(event.get_upgrade_strategy().upgrade_name);

## returns if successfully removed
func remove_upgrades(amount: int) -> bool:
	if self.upgrade_get_order.size() < amount:
		return false;
	for i in range(amount):
		var upgrade_name: String = self.upgrade_get_order.pop_back();
		var upgrade: UpgradeStrategy = self.upgrade_pool.get(upgrade_name);
		upgrade.on_remove();
	return true;

func remove_upgrade() -> bool:
	return self.remove_upgrades(1);
