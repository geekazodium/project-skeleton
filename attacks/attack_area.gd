extends Area2D
class_name AttackArea

@export var damage: float = 2;
@export var damage_cooldown: float = .5;
var damage_cooldown_timer: float = 0.;

@export var knockback_amount: float = 200;
@export var stun_duration: float = .5;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if damage_cooldown_timer > 0:
		damage_cooldown_timer -= delta;

func process_hits():
	if damage_cooldown_timer > 0:
		return;
	
	var hit: Node2D = self.get_hit_nearest();
	if hit == null:
		return;
	
	self.target_collide_damage(hit);
	self.target_collide_knockback(hit);
	
func get_hit_nearest() -> PhysicsBody2D:
	var nearest: PhysicsBody2D = null;
	var nearest_distance: float = 0.;
	for body in self.get_overlapping_bodies():
		#optimization since exact distance is not required, just comparison.
		#(vector length requires sqrt operation, length_squared does not.)
		var distance = (body.global_position - self.global_position).length_squared();
		if nearest == null || nearest_distance > distance:
			nearest = body;
			nearest_distance = distance;
	return nearest;

func target_collide_damage(target: Node2D):
	var hit: HealthTracker = target.get_node(HealthTracker.default_path);
	hit.change_health(-damage);
	damage_cooldown_timer = damage_cooldown;

func target_collide_knockback(target: Node2D):
	var dir = target.global_position - self.global_position;
	var hit_entity: EntityBody = target;
	hit_entity.apply_knockback(dir.normalized() * knockback_amount);
	hit_entity.apply_stun(stun_duration);
