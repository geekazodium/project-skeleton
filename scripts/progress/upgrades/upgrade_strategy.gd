extends Resource
class_name UpgradeStrategy

var _minions: Node2D = null;

@export var upgrade_name: String = "";
var level: int = 0;
var ready: bool = false;

func instantiate_button(button: PackedScene) -> Button:
	var inst: Button = button.instantiate();
	inst.text = self.upgrade_name;
	inst.pressed.connect(self.on_select);
	return inst;

func on_select():
	if !self.ready:
		self._ready();
		self.ready = true;
	self.level += 1;
	self._level_change(1);
	
	var powerup_selected_event: PowerUpSelectedEvent = PowerUpSelectedEvent.new_inst(self);
	EventBus.powerup_selected.emit(powerup_selected_event);
	powerup_selected_event.free();
	print("level up skill ",  upgrade_name, " to level ", self.level);

func get_minions() -> Array[Node]:
	return self._minions.get_children();

func set_minions(minions: Node2D):
	self._minions = minions;
	
## Called when this upgrade is selected for the first time
func _ready():
	pass;

@warning_ignore("unused_parameter")
func prerequisites_met(pool: Dictionary) -> bool:
	return false;

## Called when this upgrade level is modified, after _ready is called
@warning_ignore("unused_parameter")
func _level_change(amount: int):
	pass;
