@tool
extends EditorPlugin
class_name NoSpaghettiPlugin

static var instance: NoSpaghettiPlugin;

@export var path: String = "";

var main_dock: SpaghettiMenu;
var main_dock_scene: PackedScene = preload("res://addons/no_spaghetti/menus/spaghetti_menu.tscn");
var spaghetti_checker: SpaghettiChecker;

## initialize plugin
func _enter_tree() -> void:
	SpaghettiLogger.debug("NoSpaghetti has been enabled");
	SpaghettiLogger.rich("thank you for using [color=Orange]NoSpaghetti [color=White]0.3-unstable");
	
	SpaghettiLogger.debug("instantiating custom settings...");
	SpaghettiSettings.register_properties();
	
	SpaghettiLogger.debug("instantiating and adding main dock...");
	self.main_dock = self.main_dock_scene.instantiate() as SpaghettiMenu;
	if self.main_dock == null:
		SpaghettiLogger.error("failed to instantiate spaghetti menu...");
	add_control_to_dock(DOCK_SLOT_LEFT_UL, self.main_dock);
	
	SpaghettiLogger.debug("instantiating checker...");
	self.spaghetti_checker = SpaghettiChecker.new();
	self.add_child(self.spaghetti_checker);
	
	SpaghettiLogger.debug("connecting check program signal...");
	self.main_dock.check_button.pressed.connect(self.spaghetti_checker.check_program);
	self.spaghetti_checker.lint_warnings_generated.connect(self.main_dock.create_warning_display);
	
	self.spaghetti_checker.load_rules(ProjectSettings.get_setting(SpaghettiSettings.RULES_SRC));
	
	SpaghettiLogger.debug("setting instance...");
	self.instance = self;

## remove plugin
func _exit_tree() -> void:
	SpaghettiLogger.debug("removing and freeing main dock...");
	remove_control_from_docks(self.main_dock);
	self.main_dock.queue_free();
	
	SpaghettiLogger.debug("freeing checker...");
	self.main_dock.queue_free();
	
	SpaghettiLogger.debug("NoSpaghetti has been disabled");
	self.instancce = null;
