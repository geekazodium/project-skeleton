extends Area2D
class_name InteractionArea2D

@export var interact_action: String = "";
var last_hit_area_path: NodePath;

func _physics_process(_delta: float) -> void:
	var hit_area: InteractableArea2D = AttackArea.get_hit_nearest_area(self) as InteractableArea2D;
	
	var hit_area_path: NodePath = get_node_path_or_default(hit_area);
	if hit_area_path != self.last_hit_area_path:
		self.notify_last_node(self.last_hit_area_path);
		if hit_area != null:
			hit_area.on_target();
	
	self.last_hit_area_path = hit_area_path;

	if Input.is_action_just_pressed(self.interact_action):
		if hit_area == null:
			return;
		hit_area.on_interact();

func notify_last_node(node_path: NodePath) -> void:
	var node: InteractableArea2D = self.get_tree().root.get_node_or_null(node_path) as InteractableArea2D;
	if node == null:
		return;
	node.on_lose_target();

static func get_node_path_or_default(nullable_node: Node) -> NodePath:
	if nullable_node == null || !nullable_node.is_inside_tree():
		return NodePath();
	return nullable_node.get_path();
