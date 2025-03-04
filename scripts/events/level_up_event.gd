extends Object
class_name LevelUpEvent

var experience_tracker: ExperienceTracker = null;
var level: int = 0;

@warning_ignore("shadowed_variable")
static func new_inst(experience_tracker: ExperienceTracker, level: int) -> LevelUpEvent:
	var _self: LevelUpEvent = LevelUpEvent.new();
	_self.level = level;
	_self.experience_tracker = experience_tracker;
	return _self;

func get_experience_tracker() -> ExperienceTracker:
	return self.experience_tracker;

func get_level() -> int:
	return level;
