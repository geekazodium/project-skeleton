extends Node2D
class_name FollowTargetState

## Class is a state to be added to a parent state machine as a possible state,
## Node must have parent of state machine.
## This state passes the location of target that is stored in `target_tracker`,
## to the `nav_agent` and then moves the `entity_body` towards the next point
## returned by the `nav_agent` if target is at any point lost, it switches the
## state machine to `target_lost_state`
##
## Use in enemies that need to be able to follow a target. must have a
## navigation agent 2d in that entity and set the `nav_agent` var to that.

@export var target_tracker: TargetTracker = null;
@export var character_body: EntityBody = null;
@export var nav_agent: NavigationAgent2D = null;
@export var target_lost_state: String = "";

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if nav_agent == null:
		push_error("no nav agent set on node");

func _process(_delta: float) -> void:
	pass;

# Called every physics tick. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !self.target_tracker.has_target():
		StateMachine.switch_state(self, target_lost_state);
		return;
	var target = target_tracker.get_target();
	character_body.move_in_direction(self.get_nav_dir(target.global_position), delta);
	
func get_nav_dir(target_pos: Vector2) -> Vector2:
	self.nav_agent.target_position = target_pos;
	var dir = self.nav_agent.get_next_path_position() - character_body.global_position;
	return dir.normalized();
