extends Object
class_name PostExperienceGainEvent

var experience_tracker: ExperienceTracker = null;

static func new_inst(experience_tracker: ExperienceTracker) -> PostExperienceGainEvent:
	var _self: PostExperienceGainEvent = PostExperienceGainEvent.new();
	_self.experience_tracker = experience_tracker;
	return _self;

func get_experience_tracker() -> ExperienceTracker:
	return self.experience_tracker;
