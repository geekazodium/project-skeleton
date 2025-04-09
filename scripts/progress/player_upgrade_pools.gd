extends Node
class_name PlayerUpgradePools

@export var generic_upgrade_pool: UpgradePool = null;
@export var special_upgrade_pools: Dictionary = {};

func _ready() -> void:
	EventBus.trade_upgrades.connect(self.on_trade_upgrades);
	
func on_trade_upgrades(key: String):
	var node: Node = self.get_node(self.special_upgrade_pools.get(key));
	var upgrade_pool: SpecialUpgradePool = node as SpecialUpgradePool;
	if upgrade_pool == null:
		push_error("failed to get key \"" + key + "\" in special upgrade pool");
		return;
	
	if self.generic_upgrade_pool.remove_upgrades(2):
		upgrade_pool.generate_upgrades();
