extends Node2D
class_name EntityWaveSpawner

@export var spawn_radius: float = 0;

@export var spawn_to: Node2D = null;

@export var enemy_waves: Array[EnemyWave] = [];

var current_wave: int = -1;

@export var spawn_safe_area: Area2D = null;
@export var next_wave_timer: Timer = null;

var spawning: bool = false;

func _ready() -> void:
	self.spawn_wave();

func _physics_process(delta: float) -> void:
	if self.spawn_safe_area.has_overlapping_bodies():
		return;
		
	if !self.spawning: 
		return;
	
	if self.enemy_waves[self.current_wave].spawining_done():
		self.spawning = false;
		self.next_wave_timer.stop();
		self.next_wave_timer.start();
	else:
		var random_offset = Vector2.UP.rotated(randf_range(0,PI * 2)) * self.sqrt_distribution(0,self.spawn_radius);
		var spawn_position = self.global_position + random_offset;
		self.enemy_waves[self.current_wave].attempt_spawn(self.spawn_to,spawn_position);

func spawn_wave() -> void:
	self.spawning = true;
	self.current_wave += 1;
	self.current_wave = min(self.current_wave, self.enemy_waves.size() - 1);
	self.enemy_waves[self.current_wave].reset();

func sqrt_distribution(min_val: int, max_val: int):
	return max(randf_range(min_val,max_val),randf_range(min_val,max_val));
