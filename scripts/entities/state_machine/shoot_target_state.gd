extends Node2D
class_name ShootTargetState

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
@export var cooldown_ended_state: StringName = "";
@export var target_lost_state: StringName = "";
@export var cooldown_timer: Timer = null;
@export var nav_agent: NavigationAgent2D = null;
@export var character_body: EntityBody;

@export var projectile: PackedScene = null;

func process(_delta: float) -> void:
	pass;

func cooldown_ended() -> void:
	if StateMachine.is_active_state(self):
		StateMachine.switch_state(self,cooldown_ended_state);

# Called every physics tick. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta: float) -> void:
	if !self.target_tracker.has_target():
		StateMachine.switch_state(self, target_lost_state);
		return;
	
	var target = target_tracker.get_target();
	if self.cooldown_timer.is_stopped():
		var relative_target_pos: Vector2 = target.global_position - self.character_body.global_position
		self.spawn_projectile(atan2(relative_target_pos.y,relative_target_pos.x));
		self.cooldown_timer.start();
	else:
		return;
		#self.character_body.move_in_direction(self.get_nav_dir(target.global_position), delta);
	
func get_nav_dir(target_pos: Vector2) -> Vector2:
	self.nav_agent.target_position = target_pos;
	var dir = self.nav_agent.get_next_path_position() - character_body.global_position;
	return dir.normalized();

func spawn_projectile(projectile_rotation: float) -> void:
	var projectile_inst: Node2D = self.projectile.instantiate() as Node2D;
	EntityGroups.add_projectile(projectile_inst);
	projectile_inst.global_position = self.global_position;
	projectile_inst.global_rotation = projectile_rotation;
	projectile_inst.reset_physics_interpolation();
