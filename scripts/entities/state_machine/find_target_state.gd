extends Node2D

@export var target_tracker: TargetTracker = null;
@export var detection_area: Area2D = null;
@export var detected_state: String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	
func _on_body_enter_detection(body: Node2D):
	if !StateMachine.is_active_state(self):
		return;
	target_tracker.set_target(body);
	StateMachine.switch_state(self, detected_state);
