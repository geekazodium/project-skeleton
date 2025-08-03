extends Node
class_name ExperienceDropOnDeath

@export var experience_value: float = 1;

func death(event: EntityDeathEvent):
	var to_replace: Node2D = event.get_entity();
	EventBus.spawn_experience.emit(to_replace.global_position, self.experience_value);
