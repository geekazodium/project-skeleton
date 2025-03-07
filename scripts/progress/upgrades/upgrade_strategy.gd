extends Resource
class_name UpgradeStrategy

@export var upgrade_name: String = "";
var level: int = 0;

func instantiate_button(button: PackedScene) -> Button:
	var inst: Button = button.instantiate();
	inst.text = self.upgrade_name;
	inst.pressed.connect(self.on_select);
	return inst;

func on_select():
	self.level += 1;
	print("level up");
