extends Node2D

@export var velocity: Vector2;
@export var animation_player: AnimationPlayer;
@export var throw_animation: StringName;

var active: bool = false;

@export var hitbox: Area2D;

var heal_per_second: float = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.velocity = self.velocity.rotated(randf_range(0,PI*2));
	self.animation_player.play(self.throw_animation);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.global_position += self.velocity * delta;
	var scale_fac: float = pow(FollowCamera2D.EULER_CONST,-delta * 2.);
	self.velocity *= scale_fac;
	var heal_amount = self.heal_per_second * delta;
	if !self.active:
		return;
	for collided in self.hitbox.get_overlapping_bodies():
		var hit_health_tracker: HealthTracker = HealthTracker.get_health_tracker(collided);
		if hit_health_tracker == null:
			push_warning("invalid collision");
			continue;
		hit_health_tracker.change_health(heal_amount);

func activate() -> void:
	self.velocity = Vector2.ZERO;
	self.active = true;
	self.hitbox.monitoring = true;
