extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.update_label(0);
	EventBus.connect("post_experience_gained",on_post_experience_gained);

func on_post_experience_gained(event: PostExperienceGainEvent):
	self.update_label(event.get_experience_tracker().level);
	
func update_label(level: int):
	self.text = "level: " + String.num_int64(level);
