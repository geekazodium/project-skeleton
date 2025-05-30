extends Resource
class_name UpgradeStrategy

@export var upgrade_name: String = "";
var _upgrade_key: StringName = &"";
var level: int = 0;
var ready: bool = false;

func set_upgrade_key(key: StringName):
	if self._upgrade_key != &"" && self._upgrade_key != key:
		push_error("attempted to add same upgrade into 2 pools");
		return;
	self._upgrade_key = key;

func get_upgrade_key() -> StringName:
	return self._upgrade_key;

func instantiate_button(button: PackedScene) -> Button:
	var inst: Button = button.instantiate();
	inst.text = self.upgrade_name;
	inst.pressed.connect(self.on_select);
	return inst;

func on_select():
	if !self.ready:
		self._ready();
		self.ready = true;
	self._add_to_level(1);
	
	var powerup_selected_event: PowerUpSelectedEvent = PowerUpSelectedEvent.new_inst(self);
	EventBus.powerup_selected.emit(powerup_selected_event);
	powerup_selected_event.free();
	print("level up skill ",  upgrade_name, " to level ", self.level);

func on_remove():
	if self.level <= 0:
		print("failed to remove upgrade ", upgrade_name);
		return;
	self._add_to_level(-1);
	
	var powerup_removed_event: PowerUpRemovedEvent = PowerUpRemovedEvent.new_inst(self);
	EventBus.powerup_removed.emit(powerup_removed_event);
	powerup_removed_event.free();

func _add_to_level(amount: int):
	self.level += amount;
	self._level_change(amount);
	
## Called when this upgrade is selected for the first time
func _ready():
	pass;

## Called when this upgrade level is modified, after _ready is called
@warning_ignore("unused_parameter")
func _level_change(amount: int):
	pass;
