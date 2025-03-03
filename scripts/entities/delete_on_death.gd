extends Node
class_name DeleteOnDeath

signal death(dead_node: Node2D);

func _on_health_change(current: float):
	if self.get_parent().is_queued_for_deletion():
		return;
	if current <= 0.:
		self.emit_signal("death", self.get_parent());
		self.get_parent().queue_free();
