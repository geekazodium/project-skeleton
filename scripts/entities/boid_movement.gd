extends Node2D
class_name BoidMovement

## Class is a replacement for modeling player controlled minion movements
##
## for an in-depth explaination of how boids works, please see:
##    https://youtu.be/bqtqltqcQhw by Sebastian Lague
##
## This is an implementation of that, `deferred_velocity` node should have a
## physics process priority higher than this, meaning if this has a physics
## process priority of 2, `deferred_velocity` node should have priority 3 or above
## `body` physics process priority should be higher than `deferred_velocity`
##
## this is done to ensure that all accelerations are calculated using the previous
## frame's velocities, since otherwise the behavior can be inconsistient when
## one instance checks for the previous frame's other velocities while the
## next one checks a mix and then it all goes wrong

@export var body: EntityBody = null;
@export var nearby_detection: Area2D = null;

@export var alignment_force: float = 2;
@export var cohesion_force: float = .5;
@export var seperation_force: float = 2;

## this is the protected range, but squared, since there is no direct use
## of the protected range (optimization since distance squared is faster than
## calculating the distance, and does the same for the purposes of comparison)
## (distance requires a square root calculation)
@export var protected_range_squared: float = 15000;
@export var mouse_force_strength: float = 1;
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
			seperation_force_avg -= position_difference.normalized();
			seperation_force_count += 1;
	
	var force = Vector2.ZERO;
	force += self.get_local_mouse_position().normalized() * mouse_force_strength;
	if nearby_detection.has_overlapping_bodies():
		force += alignment_force_avg.normalized() * self.alignment_force;
		force += cohesion_force_center.normalized() * self.cohesion_force;
		if seperation_force_count > 0:
			force += seperation_force_avg * self.seperation_force;
	
	self.deferred_velocity.direction_to_move = force + direction * .2;
	#self.queue_redraw();

##commented out, useful for debugging cohesion and other forces
#func _draw() -> void:
	#var direction: Vector2 = self.body.velocity.normalized();
	#draw_line(Vector2.ZERO,direction * 100, Color.WHITE);
