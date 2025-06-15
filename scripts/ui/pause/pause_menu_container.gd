extends Control

@export var default_button: Button;

func _process(delta: float) -> void:
	if !self.get_tree().paused:
		if Input.is_action_just_pressed("ui_cancel"):
			self.on_pause();

func _on_continue_button_pressed() -> void:
	self.visible = false;
	self.get_tree().paused = false;

func on_pause() -> void:
	self.visible = true;
	self.get_tree().paused = true;
	self.default_button.grab_focus();
