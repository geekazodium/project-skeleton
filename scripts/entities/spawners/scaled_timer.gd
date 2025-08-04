extends Node
class_name ScaledTimer

@export var this_time_scale: float = 1;
@export var wait_time: float = 0;
var time_left: float = 0;

signal timeout();

func _physics_process(delta: float) -> void:
	if self.time_left > 0:
		self.time_left -= delta * self.this_time_scale;
		if self.time_left <= 0:
			self.time_left = 0;
			self.timeout.emit();

func start(duration: float = wait_time) -> void:
	self.time_left = duration;

func stop() -> void:
	self.time_left = 0;
