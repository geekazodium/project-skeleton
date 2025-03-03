extends Node
class_name ExperienceTracker

@export var xp_req_increase_per_level: float = 10;
@export var base_xp_req_per_level: float = 20;

var level: int = 0;
var experience: float = 0;

func get_xp_until_level_up() -> float:
	return base_xp_req_per_level + level * xp_req_increase_per_level;

func gain_xp(amount: float):
	var exp_gained_event = ExperienceGainEvent.new_inst(self, amount);
	EventBus.emit_signal("experience_gained", exp_gained_event);
	self.experience += exp_gained_event.amount_gained;
	exp_gained_event.free();
	
	while self.experience >= get_xp_until_level_up():
		self.experience -= get_xp_until_level_up();
		self.level += 1;
		var level_up_event = LevelUpEvent.new_inst(self, self.level);
		EventBus.emit_signal("level_up",level_up_event);
		level_up_event.free();
	
	var post_exp_gained_event = PostExperienceGainEvent.new_inst(self);
	EventBus.emit_signal("post_experience_gained", post_exp_gained_event);
	post_exp_gained_event.free();

static func find_node(_parent: Node) -> ExperienceTracker:
	return _parent.get_node("ExperienceTracker");
