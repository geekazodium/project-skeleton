extends Resource
class_name EnemyWave

@export var spawns: Array[PackedScene] = [];

@export var spawn_amount: int = 0;

var spawn_count: int = 0;

func instantiate() -> Node2D:
	return self.spawns.pick_random().instantiate() as Node2D;

func attempt_spawn(spawn_to: Node2D, spawn_position: Vector2) -> bool:
	if self.spawn_amount <= self.spawn_count:
		push_warning("attempted spawn on a completed spawner");
		return false;
	self.spawn_count += 1;
	var new_instance = self.instantiate();
	new_instance.position = spawn_position - spawn_to.global_position;
	spawn_to.add_child(new_instance);
	return true;

func spawining_done() -> bool:
	return self.spawn_amount <= self.spawn_count;

func reset():
	self.spawn_count = 0;
