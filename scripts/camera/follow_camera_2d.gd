extends Camera2D
class_name FollowCamera2D

const EULER_CONST: float = 2.71828182845904523536028747135266250;

@export var target: Node2D = null;
@export var tween_velocity: float = 4;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.target == null:
		return;
	var position: Vector2 = self.target.global_position;
	var scale_fac: float = 1.-pow(EULER_CONST,-delta * self.tween_velocity);
	var move_by: Vector2 = (position - self.global_position) * scale_fac;
	var new_position = self.position + move_by;
	self.position = new_position;
