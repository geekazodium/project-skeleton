extends Node2D
class_name EntityWaveSpawner

@export var spawn_radius: float = 0;
@export var radius_from_player: float = 0;
@export var spawn_amount: float = 0;

@export var spawn_to: Node2D = null;

var spawn_count: int = 0;
var spawn_center_position: Vector2 = Vector2.ZERO;

@export var spawns: Array[PackedScene] = [];

@export var spawn_safe_area: Area2D = null;

func _ready() -> void:
	self.spawn_count = self.spawn_amount;

func _physics_process(delta: float) -> void:
	if self.spawn_safe_area.has_overlapping_bodies():
		self.position = Vector2.UP.rotated(randf_range(0,PI * 2)) * self.radius_from_player;
		self.spawn_center_position = self.global_position;
		return;
	
	if self.spawn_count < self.spawn_amount:
		var random_offset = Vector2.UP.rotated(randf_range(0,PI * 2)) * self.sqrt_distribution(0,self.spawn_radius);
		self.spawn_count += 1;
		var spawn_position = self.spawn_center_position + random_offset;
		var new_instance = spawns.pick_random().instantiate();
		new_instance.position = spawn_position - self.spawn_to.global_position;
		self.spawn_to.add_child(new_instance);

func spawn_wave() -> void:
	self.spawn_count = 0;
	self.position = Vector2.UP.rotated(randf_range(0,PI * 2)) * self.radius_from_player;
	self.spawn_center_position = self.global_position;

func sqrt_distribution(min_val: int, max_val: int):
	return max(randf_range(min_val,max_val),randf_range(min_val,max_val));
