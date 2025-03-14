extends Node2D

## Rotates, make this the parent of something you want to
## constanly rotate around a pivot

@export var rotate_speed: float = 10;

func _physics_process(delta: float) -> void:
	self.rotation += delta * rotate_speed;
