extends Node2D

## MAKE SURE IT PROCESSES AFTER THE SPAWNER, OTHERWISE THE SPAWNER MAY MOVE INTO A WALL
## BEFORE SPAWNING AN ENTITY
## Rotates, make this the parent of something you want to
## constanly rotate around a pivot

@export var rotate_speed: float = 10;

func _physics_process(delta: float) -> void:
	self.rotation += delta * rotate_speed;
