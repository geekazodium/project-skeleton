extends Node2D

@export var rotate_speed: float = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	self.rotation += delta * rotate_speed;
