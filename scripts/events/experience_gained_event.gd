extends Object
class_name ExperienceGainEvent

var base_amount_gained: float = 0;
var amount_gained: float = 0;
var experience_tracker: ExperienceTracker = null;

static func new_inst(experience_tracker: ExperienceTracker, amount: float) -> ExperienceGainEvent:
	var _self: ExperienceGainEvent = ExperienceGainEvent.new();
	_self.amount_gained = amount;
	_self.base_amount_gained = amount;
	_self.experience_tracker = experience_tracker;
	return _self;

func get_base_amount() -> float:
	return self.base_amount_gained;
	
func add_amount(amount: float) -> ExperienceGainEvent:
	self.amount_gained += amount;
	return self;

func get_experience_tracker() -> ExperienceTracker:
	return self.experience_tracker;
