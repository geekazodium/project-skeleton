extends Container
class_name UpgradeSelector

@export var button: PackedScene = null;
@export var options_container: Container = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.level_up_tail.connect(self.on_level_up);
	
func on_level_up(event: LevelUpEvent):
	self.set_options(event.get_upgrade_options());
	self.visible = true;
	self.get_tree().paused = true;

func set_options(options: Array[UpgradeStrategy]):
	for option in options:
		var button_instance: Button = option.instantiate_button(self.button);
		button_instance.pressed.connect(self.on_resume);
		self.options_container.add_child(button_instance);

func on_resume():
	self.clean_up_options();
	self.visible = false;
	self.get_tree().paused = false;

func clean_up_options():
	for child in self.options_container.get_children():
		child.set_block_signals(true);
		child.queue_free();
