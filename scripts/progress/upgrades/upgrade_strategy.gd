extends Resource
class_name UpgradeStrategy

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
	_level_change();
	print("level up skill ",  upgrade_name, " to level ", self.level);

## Called when this upgrade is selected for the first time
func _ready():
	pass;

## Called when this upgrade level is modified, after _ready is called
func _level_change():
	pass;
