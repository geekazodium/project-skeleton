@tool
extends RichTextLabel
class_name ResultDisplay

var script_displayed: String;

func _gui_input(event: InputEvent) -> void:
	if !event.is_released(): 
		return;
	var mb_event: InputEventMouseButton = event as InputEventMouseButton;
	if mb_event == null:
		return;
	if mb_event.button_index == MOUSE_BUTTON_LEFT:
		var s: Script = load(self.script_displayed);
		NoSpaghettiPlugin.instance.get_editor_interface().edit_script(s);
