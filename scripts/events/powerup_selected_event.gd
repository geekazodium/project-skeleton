extends Object
class_name PowerUpSelectedEvent

var _upgrade_strategy: UpgradeStrategy = null;

## instantiate an 'PowerUpSelectedEvent' to pass to listeners, which may be canceled
# REMEMBER TO FREE REFERENCES AND SERIOUSLY DO NOT SAVE A REF OF EVENTS.
# Tool idea: event linting to ensure events are always freed after handled
@warning_ignore("shadowed_variable")
static func new_inst(upgrade_strategy: UpgradeStrategy) -> PowerUpSelectedEvent:
	var _self: PowerUpSelectedEvent = PowerUpSelectedEvent.new();
	_self._upgrade_strategy = upgrade_strategy;
	return _self;

func get_upgrade_strategy() -> UpgradeStrategy:
	return self._upgrade_strategy;
