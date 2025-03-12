extends Node2D
class_name BoidMovement

@export var body: EntityBody = null;
@export var nearby_detection: Area2D = null;

@export var alignment_force: float = 2;
@export var cohesion_force: float = .5;
@export var seperation_force: float = 1;
@export var protected_range_squared: float = 10;
@export var mouse_force_strength: float = .5;
@export var direction_tolerance: float = -cos(PI/4);

@export var deferred_velocity: DeferredVelocity = null;

func _physics_process(_delta: float) -> void:
	
	var alignment_force_avg: Vector2 = Vector2.ZERO;
	var seperation_force_avg: Vector2 = Vector2.ZERO;
	var seperation_force_count: int = 0;
	var cohesion_force_center: Vector2 = Vector2.ZERO;
	var other_count: int = 0;
	
	var direction: Vector2 = self.body.velocity.normalized();
	
	var overlapping: Array[Node2D] = nearby_detection.get_overlapping_bodies();
	
	for nearby_body: CharacterBody2D in overlapping:
		
		if nearby_body == self.body:
			continue;
			
		var position_difference = nearby_body.global_position - self.global_position;
		
		if position_difference.normalized().dot(-direction) < self.direction_tolerance:
			continue;
		
		other_count += 1;
		cohesion_force_center += position_difference;
		
		alignment_force_avg += nearby_body.velocity;
		
		var distance_squared: float = position_difference.length_squared();
		if distance_squared < self.protected_range_squared:
			seperation_force_avg -= position_difference / sqrt(distance_squared);
			seperation_force_count += 1;
	
	var force = Vector2.ZERO;
	force += self.get_local_mouse_position().normalized() * mouse_force_strength;
	if nearby_detection.has_overlapping_bodies():
		force += alignment_force_avg.normalized() * self.alignment_force;
		force += cohesion_force_center.normalized() * self.cohesion_force;
		if seperation_force_count > 0:
			force += seperation_force_avg.normalized() * self.seperation_force;
	
	self.deferred_velocity.direction_to_move = force + direction * .3;
	#self.queue_redraw();

##commented out, useful for debugging cohesion and other forces
#func _draw() -> void:
	#var direction: Vector2 = self.body.velocity.normalized();
	#draw_line(Vector2.ZERO,direction * 100, Color.WHITE);
