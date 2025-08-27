extends Node
class_name UpgradeFailedHandler

@export var key: StringName;
@export var dialog: DialogueResource;
@export var interactable_character: InteractableCharacter;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.trade_upgrades_failed.connect(self.on_failed);

func on_failed(event_key: StringName) -> void:
	if self.key != event_key:
		return;
	DialogueManager.show_dialogue_balloon(self.dialog).process_mode = Node.PROCESS_MODE_ALWAYS;
	DialogueManager.dialogue_ended.connect(self.on_dialog_end);
	self.interactable_character.disable_unpause();

func on_dialog_end(event_dialog: DialogueResource) -> void:
	if event_dialog != self.dialog:
		return;
	DialogueManager.dialogue_ended.disconnect(self.on_dialog_end);
	self.get_tree().paused = false;
