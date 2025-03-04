extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("post_experience_gained",on_post_experience_gain);
	
func on_post_experience_gain(event: PostExperienceGainEvent):
	self.value = event.get_experience_tracker().experience;
	self.max_value = event.get_experience_tracker().get_xp_until_level_up();
