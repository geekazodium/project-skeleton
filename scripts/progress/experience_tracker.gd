extends Node
class_name ExperienceTracker

var level: int = 0;
var experience: int = 0;

func get_xp_until_level_up() -> float:
	return 20 + level * 10;

func gain_xp(amount: float):
	experience += amount;
	
