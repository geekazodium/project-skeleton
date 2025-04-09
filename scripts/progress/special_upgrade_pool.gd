extends Node
class_name SpecialUpgradePool

@export var upgrade_pool: Dictionary = {};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for key: String in self.upgrade_pool.keys():
		var upgrade: UpgradeStrategy = self.upgrade_pool[key];
		upgrade.set_upgrade_key(key);
		upgrade.level = 0;

func generate_upgrades():
	var pool = upgrade_pool.values();
	pool.shuffle();
	var upgrades: Array[UpgradeStrategy] = [];
	upgrades.assign(pool.slice(0,3));
	
	var pool_generated_event: PowerUpsGeneratedEvent = PowerUpsGeneratedEvent.new_inst(upgrades);
	EventBus.level_ups_generated.emit(pool_generated_event);
	pool_generated_event.free();
