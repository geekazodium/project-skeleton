extends InteractableArea2D
class_name InteractableCharacter

@export var dialog: DialogueResource = null;

func _ready() -> void:
	pass

func on_interact():
	self.get_tree().paused = true;
	var ballon = DialogueManager.show_dialogue_balloon(self.dialog);
	ballon.process_mode = Node.PROCESS_MODE_ALWAYS;
	ballon.tree_exiting.connect(self.on_dialog_ended);

func on_dialog_ended():
	self.get_tree().paused = false;
