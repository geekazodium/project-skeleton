extends Node2D

@export var body: EntityBody = null;
@export var nearby_detection: Area2D = null;

@export var alignment_force: float = 2;
@export var cohesion_force: float = .5;
@export var seperation_force: float = 1;
@export var protected_range: float = 10;

@export var deferred_velocity: DeferredVelocity = null;

func _physics_process(_delta: float) -> void:
	
	var alignment_force_avg = Vector2.ZERO;
	var seperation_force_avg = Vector2.ZERO;
	var seperation_force_count: int = 0;
	var cohesion_force_center = Vector2.ZERO;
	
	var overlapping: Array[Node2D] = nearby_detection.get_overlapping_bodies();
	for nearby_body: CharacterBody2D in overlapping:
		
		cohesion_force_center += nearby_body.global_position - self.global_position;
		
		if nearby_body == self.body:
			continue;
		alignment_force_avg += nearby_body.velocity;
		
		var distance: float = nearby_body.global_position.distance_to(self.global_position);
		if distance < self.protected_range:
			seperation_force_avg += (self.global_position - nearby_body.global_position) / distance;
			seperation_force_count += 1;
	
	var force = Vector2.ZERO;
	force += self.get_local_mouse_position().normalized();
	if nearby_detection.has_overlapping_bodies():
		force += alignment_force_avg.normalized() * self.alignment_force;
		force += cohesion_force_center.normalized() * self.cohesion_force;
		if seperation_force_count > 0:
			force += seperation_force_avg.normalized() * self.seperation_force;
	
	self.deferred_velocity.direction_to_move = force.normalized();

##commented out, useful for debugging cohesion and other forces
#func _draw() -> void:
	#
	#draw_line(Vector2.ZERO, self.body.velocity, Color.PURPLE);
	#var alignment_force_avg = Vector2.ZERO;
	#var seperation_force_avg = Vector2.ZERO;
	#var seperation_force_count: int = 0;
	#var cohesion_force_center = Vector2.ZERO;
	#
	#var overlapping: Array[Node2D] = nearby_detection.get_overlapping_bodies();
	#for nearby_body: CharacterBody2D in overlapping:
		#cohesion_force_center += nearby_body.global_position - self.global_position;
		#if nearby_body == self.body:
			#continue;
		#alignment_force_avg += nearby_body.velocity;
		#
		#var distance: float = nearby_body.global_position.distance_to(self.global_position);
		#if distance < self.protected_range:
			#seperation_force_avg += (self.global_position - nearby_body.global_position) / distance;
			#seperation_force_count += 1;
	#
	#var force = Vector2.ZERO;
	#force += self.get_local_mouse_position().normalized();
	#if nearby_detection.has_overlapping_bodies():
		#force += alignment_force_avg.normalized() * 2;
		#force += cohesion_force_center.normalized();
		#draw_line(Vector2.ZERO, cohesion_force_center / overlapping.size(), Color.ORANGE, 2);
		#if seperation_force_count > 0:
			#force += seperation_force_avg;
