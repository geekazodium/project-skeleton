extends CheckButton

func _ready() -> void:
	self.button_pressed = SaveState.get_flag("me");

func _gui_input(event: InputEvent) -> void:
	SaveState.set_flag("me", self.button_pressed);
