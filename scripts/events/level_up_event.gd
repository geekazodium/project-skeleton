extends Object
class_name LevelUpEvent

var _experience_tracker: ExperienceTracker = null : get = get_experience_tracker;
var _upgrade_options: Array[UpgradeStrategy] = [] : set = set_upgrade_options, get = get_upgrade_options;
var _level: int = 0 : get = get_level;

var _finalized: bool = false : get = is_finalized;

@warning_ignore("shadowed_variable")
static func new_inst(experience_tracker: ExperienceTracker, level: int) -> LevelUpEvent:
	var _self: LevelUpEvent = LevelUpEvent.new();
	_self._level = level;
	_self._experience_tracker = experience_tracker;
	return _self;

func finalize():
	_finalized = true;

func get_experience_tracker() -> ExperienceTracker:
	return _experience_tracker;

func get_level() -> int:
	return _level;

func set_upgrade_options(options: Array[UpgradeStrategy]):
	if _finalized:
		print_stack();
		push_error("invalid access pattern, do not modifiy level up event once finalized!");
		return;
	_upgrade_options = options;
	
func get_upgrade_options() -> Array[UpgradeStrategy]:
	return _upgrade_options;
	
func is_finalized() -> bool:
	return _finalized;
