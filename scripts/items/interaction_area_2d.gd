extends Area2D
class_name InteractionArea2D

@export var interact_action: String = "";

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(self.interact_action):
		var hit_area: InteractableArea2D = AttackArea.get_hit_nearest_area(self) as InteractableArea2D;
		if hit_area == null:
			return;
		hit_area.on_interact();
