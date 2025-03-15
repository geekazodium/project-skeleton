extends Node

@export var upgrade_pool: Array[UpgradeStrategy] = [];
@export var minions: Node2D = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_up.connect(self.on_level_up);

func on_level_up(event: LevelUpEvent):
	var _level: int = event.get_level();
	upgrade_pool.shuffle()
	var upgrades: Array[UpgradeStrategy] = upgrade_pool.slice(0,3);
	
	for upgrade in upgrades:
		upgrade.set_minions(self.minions);
	
	event.set_upgrade_options(upgrades);
