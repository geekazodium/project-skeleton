extends Object
class_name LevelUpEvent

var _experience_tracker: ExperienceTracker = null : get = get_experience_tracker;
var _level: int = 0 : get = get_level;

@warning_ignore("shadowed_variable")
static func new_inst(experience_tracker: ExperienceTracker, level: int) -> LevelUpEvent:
	var _self: LevelUpEvent = LevelUpEvent.new();
	_self._level = level;
	_self._experience_tracker = experience_tracker;
	return _self;

func get_experience_tracker() -> ExperienceTracker:
	return _experience_tracker;

func get_level() -> int:
	return _level;
