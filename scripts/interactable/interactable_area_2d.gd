extends Area2D
class_name InteractableArea2D

@export var dialog: DialogueResource = null;

func on_interact():
	self.get_tree().paused = true;
	var ballon = DialogueManager.show_dialogue_balloon(self.dialog);
	ballon.process_mode = Node.PROCESS_MODE_ALWAYS;
	ballon.tree_exiting.connect(self.on_dialog_ended);
	self._interact();

func on_dialog_ended():
	self._dialog_ended();

func _interact():
	pass

func _dialog_ended():
	pass
