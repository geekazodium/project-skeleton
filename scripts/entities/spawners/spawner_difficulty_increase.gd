extends Node

@export var spawners: Array[EntitySpawner] = [];
@export var timer_scale_fac: float = .95;
@export var scale_per_second: float = .999;

func _ready() -> void:
	EventBus.connect("enemy_dead", self.on_enemy_dead);

func _process(delta: float) -> void:
	scale_spawner_timers(pow(scale_per_second,delta));

func on_enemy_dead(_event: EntityDeathEvent):
	scale_spawner_timers(timer_scale_fac);
	
func scale_spawner_timers(factor: float):
	for spawner in spawners:
		spawner.spawn_interval_min *= factor;
		spawner.spawn_interval_max *= factor;
		if spawner.spawn_interval_min < .1:
			spawner.spawn_interval_min = .4;
		if spawner.spawn_interval_max < .1:
			spawner.spawn_interval_max = .4;
