extends Object
class_name DialogNextClickedEvent

## instantiate an 'DialogNextClickedEvent' to pass to listeners, which may be canceled
# REMEMBER TO FREE REFERENCES AND SERIOUSLY DO NOT SAVE A REF OF EVENTS.
# Tool idea: event linting to ensure events are always freed after handled

# currently a unit type, will add stuff when player gets choices (if they do)
static func new_inst() -> DialogNextClickedEvent:
	var _self: DialogNextClickedEvent = DialogNextClickedEvent.new();
	return _self;
