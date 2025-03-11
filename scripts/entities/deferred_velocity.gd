extends Node
class_name DeferredVelocity

var direction_to_move: Vector2 = Vector2.ZERO;

@export var body: EntityBody = null;

func _physics_process(_delta: float) -> void:
	self.body.move_in_direction(self.direction_to_move);
	self.direction_to_move = Vector2.ZERO;
