extends InteractableArea2D
class_name InteractableCharacter

## This node represents NPC characters that the player can interact with which 
## opens a dialog. The dialog can optionally links to an upgrade pool and 
## this node will manage game pausing during the dialog, as long as the only
## signal the dialog emits is `EventBus.trade_upgrades`.

var unpause: bool = true;

func _interact() -> void:
	if !EventBus.level_ups_generated.is_connected(self.disable_unpause_on_end):
		EventBus.level_ups_generated.connect(self.disable_unpause_on_end);
		self.unpause = true;
	else:
		push_warning("Warning: _interact called multiple times without dialog ending.");

# if level ups are generated, do not unpause
func disable_unpause_on_end(_unused: DialogueResource) -> void:
	self.unpause = false;

func disable_unpause() -> void:
	self.unpause = false;

func _dialog_ended() -> void:
	if EventBus.level_ups_generated.is_connected(self.disable_unpause_on_end):
		EventBus.level_ups_generated.disconnect(self.disable_unpause_on_end);
		if self.unpause:
			self.get_tree().paused = false;
	else:
		push_warning("Warning: _dialog_ended called without a prior _interact or disconnected signal.");
