extends Node2D

@export var experience_scene: PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.spawn_experience.connect(self.spawn_experience);

func spawn_experience(spawn_position: Vector2, experience_value: float) -> void:
	var instance: ExperienceEntity = (self.experience_scene.instantiate()) as ExperienceEntity;
	instance.position = spawn_position;
	self.add_child(instance);
	instance.xp_value = experience_value;
