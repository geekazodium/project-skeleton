extends Object
class_name EntitySpawnEvent

var entity: EntityBody = null;
var canceled: bool = false;

## instantiate an 'EntityDeathEvent' to pass to listeners, which may be canceled
# REMEMBER TO FREE REFERENCES AND SERIOUSLY DO NOT SAVE A REF OF EVENTS.
# Tool idea: event linting to ensure events are always freed after handled
@warning_ignore("shadowed_variable")
static func new_inst(entity: EntityBody) -> EntitySpawnEvent:
	var _self: EntitySpawnEvent = EntitySpawnEvent.new();
	_self.entity = entity;
	return _self;

@warning_ignore("shadowed_variable")
func set_canceled(canceled: bool):
	self.canceled = canceled;

func get_entity() -> Node2D:
	return self.entity;
	
func is_canceled() -> bool:
	return self.canceled;
