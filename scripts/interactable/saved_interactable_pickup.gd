extends InteractableArea2D
class_name SavedInteractablePickup

@export var interacted_flag_name: String = "";

func _ready() -> void:
	if interacted_flag_name == "":
		push_error("no picked up flag name set");
		return;
	
	var picked_up: bool = SaveState.get_flag(self.interacted_flag_name);
	if picked_up:
		self.queue_free();

func _interact():
	SaveState.set_flag(self.interacted_flag_name, true);
	print("picked up item "+self.name);

func _dialog_ended():
	self.get_tree().paused = false;
	self.queue_free();
