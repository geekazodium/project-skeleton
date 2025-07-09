extends Area2D
class_name InteractableArea2D

## This script defines an abstract base class for dialog-based interactable objects in the game world.
## It is intended to be extended by other scripts to implement specific interactable behaviors.
## The node is designed to represent any object that can trigger dialog interactions.

@export var dialog: DialogueResource = null;
var default_modulate: Color;
@export var targeting_modulate: Color;

func on_interact() -> void:
	print("Interaction started with dialog: ", self.dialog);
	self.get_tree().paused = true;
	var ballon = DialogueManager.show_dialogue_balloon(self.dialog);
	ballon.process_mode = Node.PROCESS_MODE_ALWAYS;
	ballon.tree_exiting.connect(self.on_dialog_ended);
	self._interact();

func on_dialog_ended() -> void:
	print("Dialogue ended");
	self._dialog_ended();

func _interact() -> void:
	pass

func _dialog_ended() -> void:
	pass

func on_target() -> void:
	self.default_modulate = self.modulate;
	self.modulate = self.targeting_modulate;

func on_lose_target() -> void:
	self.modulate = self.default_modulate;
