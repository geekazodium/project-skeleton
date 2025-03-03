extends Area2D

var tween_to: Node2D = null;
var tween_timer: float = 0.;

@export var tween_velocity = 5;
@export var distance_tolerance = 50;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tween_to == null:
		return;
	var position = tween_to.position;
	var scale_fac: float = 1.-pow(FollowCamera2D.EULER_CONST,-delta * self.tween_velocity);
	var move_by: Vector2 = (position - self.global_position) * scale_fac;
	self.position = self.position + move_by;
	if (self.position - tween_to.position).length_squared() < distance_tolerance * distance_tolerance:
		
		self.queue_free();

func _on_body_entered(body: Node2D) -> void:
	self.tween_to = body;
