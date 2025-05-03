extends InteractableArea2D
class_name InteractableCharacter

var unpause: bool = true;

func _interact() -> void:
	EventBus.trade_upgrades.connect(self.disable_unpause);
	self.unpause = true;

func disable_unpause(_unused) -> void:
	self.unpause = false;

func _dialog_ended() -> void:
	EventBus.trade_upgrades.disconnect(self.disable_unpause);
	if self.unpause:
		self.get_tree().paused = false;
	self.unpause = true;
