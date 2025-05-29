extends Resource
class_name EnemyWave

@export var spawns: Array[PackedScene] = [];
@export var spawn_amounts: Array[int] = [];

var spawns_left: Array[int] = [];

func instantiate() -> Node2D:
	var i: int = 0;
	while i < self.spawns_left.size():
		if self.spawns_left[i] > 0:
			break;
		i += 1;
	self.spawns_left[i] -= 1;
	return self.spawns[i].instantiate() as Node2D;

func attempt_spawn(spawn_to: Node2D, spawn_position: Vector2) -> bool:
	if self.spawining_done():
		push_warning("attempted spawn on a completed spawner");
		return false;
	var new_instance = self.instantiate();
	new_instance.position = spawn_position - spawn_to.global_position;
	spawn_to.add_child(new_instance);
	return true;

func spawining_done() -> bool:
	for l in spawns_left:
		if l > 0:
			return false;
	return true;

func reset():
	self.spawns_left = self.spawn_amounts.duplicate();
