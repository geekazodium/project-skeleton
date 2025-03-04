extends Node

@export var spawners: Array[EntitySpawner] = [];
@export var timer_scale_fac: float = .95;

func _ready() -> void:
	EventBus.connect("enemy_dead", self.on_enemy_dead);

func on_enemy_dead(_event: EntityDeathEvent):
	for spawner in spawners:
		spawner.spawn_interval_min *= timer_scale_fac;
		spawner.spawn_interval_max *= timer_scale_fac;
