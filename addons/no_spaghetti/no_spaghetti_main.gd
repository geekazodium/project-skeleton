@tool
extends EditorPlugin
class_name NoSpaghettiPlugin

var main_dock: Control;
var main_dock_scene: PackedScene = preload("res://addons/no_spaghetti/menus/spaghetti_checker.tscn");

func _enter_tree() -> void:
	SpaghettiLogger.debug("NoSpaghetti has been enabled");
	SpaghettiLogger.rich("thank you for using NoSpaghetti :3 v0.1b");
	
	SpaghettiLogger.debug("instantiating and adding main dock...");
	self.main_dock = self.main_dock_scene.instantiate();
	add_control_to_dock(DOCK_SLOT_LEFT_UL, self.main_dock);

func _exit_tree() -> void:
	SpaghettiLogger.debug("removing and freeing main dock...");
	remove_control_from_docks(self.main_dock);
	self.main_dock.free();
	
	SpaghettiLogger.debug("NoSpaghetti has been disabled");
