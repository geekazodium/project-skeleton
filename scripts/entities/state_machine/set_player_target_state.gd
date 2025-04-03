extends Node2D
class_name SetPlayerTargetState

## Class is a state to be added to a parent state machine as a possible state,
## Node must have parent of state machine.
## This state finds a target in `detection_area`, notifies the `target_tracker`,
## and passes state to the state in `detected_state`
##
## Use in enemies that need to find a target, usually you want to set the
## collision mask of the detection area to only player collision layer
## or minion and player collision layer.

@export var target_tracker: TargetTracker = null;
@export var detected_state: String = "";

# Called every frame, empty function to avoid errors from state machine parent
func process(_delta: float) -> void:
	pass

# Finds target and swaps parent state when target is found
func physics_process(_delta: float) -> void:
	if EntityGroups.get_players().size() > 0:
		self.target_tracker.set_target(EntityGroups.get_players()[0]);
		StateMachine.switch_state(self,self.detected_state);
