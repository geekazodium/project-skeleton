extends UpgradeStrategy

@export var spawns_per_second: float = .2;
@export var spawn_scene: PackedScene;

var spawn_timer: float = 0;

func _ready():
	EventBus.physics_processed.connect(self.on_tick);

func on_tick(delta: float) -> void:
	self.spawn_timer += delta * self.spawns_per_second * self.level;
	while self.spawn_timer >= 1.:
		self.spawn_timer -= 1.;
		var spawn_projectile: Node2D = self.spawn_scene.instantiate() as Node2D;
		EntityGroups.add_projectile(spawn_projectile);
		spawn_projectile.global_position = (EntityGroups.get_players()[0] as Node2D).global_position;
		spawn_projectile.reset_physics_interpolation();

func _level_change(_change: int):
	self.spawn_timer = 1;
