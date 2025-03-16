extends Container

@export var upgrade_display: PackedScene = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.powerup_selected.connect(self.on_powerup_selected);

func on_powerup_selected(event: PowerUpSelectedEvent):
	var upgrade_strategy: UpgradeStrategy = event.get_upgrade_strategy();
	var node_name = "gen-" + upgrade_strategy.resource_path.replace("res://","").replace(".tres","").replace("/","-");
	
	if !self.has_node(node_name):
		var inst: Node = self.upgrade_display.instantiate();
		inst.name = node_name;
		self.add_child(inst);
	
	var node: Label = self.get_node(node_name);
	node.text = upgrade_strategy.upgrade_name + " " + String.num_int64(upgrade_strategy.level);
