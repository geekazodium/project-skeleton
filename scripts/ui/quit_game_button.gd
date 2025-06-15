extends Button
class_name QuitGameButton

@export var confirmation_container: Control;
@export var default_dialog_button: Button;

func _pressed() -> void:
	self.confirmation_container.visible = true;
	self.default_dialog_button.grab_focus();

func _on_confirmation_container_hidden() -> void:
	self.confirmation_container.visible = false;

func _on_confirm_button_pressed() -> void:
	self.get_tree().quit();

func _on_cancel_button_pressed() -> void:
	self.confirmation_container.visible = false;
