extends Object
class_name EntityDeathEvent

var entity: Node2D = null;
var canceled: bool = false;

## instantiate an 'EntityDeathEvent' to pass to listeners, which may be canceled
# REMEMBER TO FREE REFERENCES AND SERIOUSLY DO NOT SAVE A REF OF EVENTS.
# Tool idea: event linting to ensure events are always freed after handled
@warning_ignore("shadowed_variable")
static func new_inst(entity: Node2D) -> EntityDeathEvent:
	var _self: EntityDeathEvent = EntityDeathEvent.new();
	_self.entity = entity;
	return _self;

@warning_ignore("shadowed_variable")
func set_canceled(canceled: bool):
	self.canceled = canceled;

func get_entity() -> Node2D:
	return self.entity;
	
func is_canceled() -> bool:
	return self.canceled;
