extends Node
class_name UserControlledMovement

@export var move_up_action: String = "";
@export var move_down_action: String = "";
@export var move_left_action: String = "";
@export var move_right_action: String = "";

@export var entity_body: EntityBody = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Vector2(
		Input.get_axis(move_left_action,move_right_action),
		Input.get_axis(move_up_action,move_down_action));
	
	if direction == Vector2.ZERO && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		direction = entity_body.get_local_mouse_position();
	
	self.entity_body.move_in_direction(direction.normalized());
