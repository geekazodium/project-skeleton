extends Area2D
class_name AttackArea

@export var damage: float = 2;
@export var damage_cooldown: float = .5;
var damage_cooldown_timer: float = 0.;

@export var knockback_amount: float = 500;
@export var stun_duration: float = .25;

@export var damage_event: String = "";
@export var hit_animation: AnimatedSprite2D = null;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if damage_cooldown_timer > 0:
		damage_cooldown_timer -= delta;
	else:
		self.visible = false;
		self.process_hits();

func process_hits():
	if damage_cooldown_timer > 0:
		return;
	
	var hit: Node2D = get_hit_nearest_body(self);
	if hit == null:
		return;
	
	damage_cooldown_timer = damage_cooldown;
	self.visible = true;
	self.target_collide_damage(hit);
	self.target_collide_knockback(hit);
	if hit_animation != null:
		hit_animation.stop();
		hit_animation.play("default", damage_cooldown / damage_cooldown_timer);
		self.rotation = ((hit.global_position - self.global_position).angle());

func target_collide_damage(target: Node2D):
	var event: EntityDealDamageEvent = EntityDealDamageEvent.new_inst(self,target,damage);
	if damage_event != "":
		EventBus.emit_signal(damage_event,event);
	
	if !event.is_canceled():
		var hit: HealthTracker = target.get_node(HealthTracker.default_path);
		hit.change_health(-event.get_final_damage());

	event.free();

func target_collide_knockback(target: Node2D):
	var dir = target.global_position - self.global_position;
	var hit_entity: EntityBody = target;
	hit_entity.apply_knockback(dir.normalized() * knockback_amount);
	hit_entity.apply_stun(stun_duration);

static func get_hit_nearest_body(_self: Area2D):
	var nearest: PhysicsBody2D = null;
	var nearest_distance: float = 0.;
	for body in _self.get_overlapping_bodies():
		#optimization since exact distance is not required, just comparison.
		#(vector length requires sqrt operation, length_squared does not.)
		var distance = (body.global_position - _self.global_position).length_squared();
		if nearest == null || nearest_distance > distance:
			nearest = body;
			nearest_distance = distance;
	return nearest;
