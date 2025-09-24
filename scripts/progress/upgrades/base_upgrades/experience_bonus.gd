extends UpgradeStrategy

@export var bonus_per_level: float = 1;

func _ready() -> void:
	EventBus.experience_gained.connect(self.on_experience_gained);

func on_experience_gained(event: ExperienceGainEvent) -> void:
	event.add_amount(event.get_base_amount() * self.bonus_per_level * sqrt(self.level));
