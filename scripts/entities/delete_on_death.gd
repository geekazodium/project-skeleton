extends Node
class_name DeleteOnDeath

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_health_change(current: float):
	if current <= 0.:
		self.get_parent().queue_free();
