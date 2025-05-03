extends Camera2D
class_name FollowCamera2D

const EULER_CONST: float = 2.71828182845904523536028747135266250;

@export var target: Node2D = null;
@export var tween_velocity: float = 4;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.target == null:
		return;
	var target_position: Vector2 = self.target.global_position;
	var scale_fac: float = 1.-pow(EULER_CONST,-delta * self.tween_velocity);
	var move_by: Vector2 = (target_position - self.global_position) * scale_fac;
	self.position = self.position + move_by;
