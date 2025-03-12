extends Node2D

@export var to_instantiate: PackedScene = null;
@export var count: int = 100;
var added: int = 0;
@export var label: Label = null;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count > added:
		added += 1;
		label.text = String.num_int64(added);
	
		var s = self.to_instantiate.instantiate();
		self.add_child(s);
		s.position = Vector2.UP * randf_range(-1000, 1000) + Vector2.LEFT * randf_range(-1000, 1000);
		
		
