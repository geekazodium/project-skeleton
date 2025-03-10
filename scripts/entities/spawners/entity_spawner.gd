extends Node2D
class_name EntitySpawner

@export var spawn_interval_min: float = .5;
@export var spawn_interval_max: float = .7;
@export var spawn_scene: PackedScene = null;

@export var spawn_to: Node = null;

@export var spawn_signal = "";

var spawn_timer: float = 0;

## Called every physics frame, ticks spawn timer and then attempts to spawn
## entity if timer is <= 0
func _physics_process(delta: float) -> void:
	if spawn_timer > 0.:
		spawn_timer -= delta;
		return;
	
	self.attempt_spawn();

func attempt_spawn():
	var new_inst = spawn_scene.instantiate();
	
	var event: EntitySpawnEvent = EntitySpawnEvent.new_inst(new_inst);
	
	if spawn_signal != "":
		EventBus.emit_signal(spawn_signal,event); 
	
	if !event.is_canceled():
		if spawn_to == null:
			self.add_child(new_inst);
		else:
			new_inst.global_position = self.global_position;
			spawn_to.add_child(new_inst);
		spawn_timer = randf_range(spawn_interval_min,spawn_interval_max);
	event.free();
