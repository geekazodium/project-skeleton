extends Container

@export var upgrade_display: PackedScene = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.powerup_selected.connect(self.on_powerup_selected);
	EventBus.powerup_removed.connect(self.on_powerup_removed);

func on_powerup_selected(event: PowerUpSelectedEvent):
	var upgrade_strategy: UpgradeStrategy = event.get_upgrade_strategy();
	var node_name = self._get_generated_node_name(upgrade_strategy.resource_path);
	
	if !self.has_node(node_name):
		var inst: Node = self.upgrade_display.instantiate();
		inst.name = node_name;
		self.add_child(inst);
	
	var node: Label = self.get_node(node_name);
	node.text = self._format_upgrade_strategy(upgrade_strategy);

func on_powerup_removed(event: PowerupRemovedEvent):
	var upgrade_strategy: UpgradeStrategy = event.get_upgrade_strategy();
	var node_name = self._get_generated_node_name(upgrade_strategy.resource_path);
	
	if !self.has_node(node_name):
		push_error("attempted to remove upgrade but upgrade does not exist in ui, possible desync");
	
	var node: Label = self.get_node(node_name);
	if upgrade_strategy.level == 0:
		self.remove_child(node);
	else:
		node.text = self._format_upgrade_strategy(upgrade_strategy);

## Assumption: user will not attempt to name anything along the lines of "--" or "assets-something"
func _get_generated_node_name(path: String) -> String:
	return "gen-" + path.replace("res://","").replace(".tres","").replace("/","-");

func _format_upgrade_strategy(upgrade_strategy: UpgradeStrategy) -> String:
	return upgrade_strategy.upgrade_name + " " + String.num_int64(upgrade_strategy.level);
