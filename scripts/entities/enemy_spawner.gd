extends Node2D

@export var spawn_interval_min: float = .5;
@export var spawn_interval_max: float = .7;
@export var spawn_scene: PackedScene = null;

var spawn_timer: float = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if spawn_timer > 0.:
		spawn_timer -= delta;
		return;
	
	self.attempt_spawn();

func attempt_spawn():
	self.add_child(spawn_scene.instantiate());
	spawn_timer = randf_range(spawn_interval_min,spawn_interval_max);
