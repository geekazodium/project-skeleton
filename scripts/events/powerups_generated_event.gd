extends Object
class_name PowerUpsGeneratedEvent

var _upgrade_options: Array[UpgradeStrategy] = [] : get = get_upgrade_options;

@warning_ignore("shadowed_variable")
static func new_inst(options: Array[UpgradeStrategy]) -> PowerUpsGeneratedEvent:
	var _self: PowerUpsGeneratedEvent = PowerUpsGeneratedEvent.new();
	_self._upgrade_options = options;
	return _self;
	
func get_upgrade_options() -> Array[UpgradeStrategy]:
	return _upgrade_options;
