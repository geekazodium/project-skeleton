extends Node2D

@export var target_tracker: Node = null;
@export var character_body: EntityBody = null;
@export var nav_agent: NavigationAgent2D = null;

@export var attack_area: AttackArea = null;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if nav_agent == null:
		push_error("no nav agent set on node");

func _process(delta: float) -> void:
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var target = target_tracker.get_target();
	character_body.move_in_direction(self.get_nav_dir(target.global_position));
	attack_area.process_hits();
	
func get_nav_dir(target_pos: Vector2) -> Vector2:
	self.nav_agent.target_position = target_pos;
	var dir = self.nav_agent.get_next_path_position() - character_body.global_position;
	return dir.normalized();
