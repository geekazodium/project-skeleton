extends Node
class_name TargetTracker

@export var target: Node2D = null;

# use to set target that is being tracked.
func set_target(target: Node2D):
	if self.target != null:
		self.target.disconnect("tree_exiting", self.target_reset);
	self.target = target;
	self.target.connect("tree_exiting", self.target_reset);

func get_target() -> Node2D:
	if self.target == null:
		push_error("attempted to get target without checking if target exists,
			remember to check if target exists before attempting to get target!");
	return self.target;

# run this before attempting to get the target if you aren't sure if a target is tracked
func has_target() -> bool:
	return self.target != null;

# use to reset target tracking
func target_reset():
	self.target = null;
