extends Node
class_name HealthTracker

@export var health: float = 10;
@export var max_health: float = 10;
@export var change_per_second: float = 0;

signal health_changed(current:float);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.health_changed.emit(self.health);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.change_health(delta * change_per_second);

func change_health(amount: float):
	self.health += amount;
	self.health_changed.emit(self.health);

static var default_path: String = "HealthTracker";
