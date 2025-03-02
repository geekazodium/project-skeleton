extends Node2D

@export var spawn_interval_min: float = .5;
@export var spawn_interval_max: float = .7;
@export var spawn_scene: PackedScene = null;

@export var spawn_to: Node = null;

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
	var new_inst = spawn_scene.instantiate();
	if spawn_to == null:
		self.add_child(new_inst);
	else:
		new_inst.global_position = self.global_position;
		spawn_to.add_child(new_inst);
	spawn_timer = randf_range(spawn_interval_min,spawn_interval_max);
