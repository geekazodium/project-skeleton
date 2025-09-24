@tool
extends VBoxContainer
class_name SpaghettiMenu

@export var check_button: Button;
@export var try_fix_button: Button;

@export var warning_display: BoxContainer;
@export var out_text_label: PackedScene;

func create_warning_display(path: String, text: String, results: Array[RegExMatch]) -> void:
	var label: RichTextLabel = out_text_label.instantiate() as ResultDisplay;
	label.text = "[color=white]"+path+"\n";
	label.text = label.text + self.get_highlighted(text,results);
	label.script_displayed = path;
	self.warning_display.add_child(label);

func get_highlighted(text: String, results: Array[RegExMatch], default: String = "[color=gray]", highlighted: String = "[color=orange]") -> String:
	var h_starts: Array[int] = [];
	var h_ends: Array[int] = [];
	for r: RegExMatch in results:
		h_starts.append(r.get_start());
		h_ends.append(r.get_end());
	h_starts.sort();
	h_ends.sort();
	
	var s_index: int = 0;
	var e_index: int = 0;
	var layers: int = 0;
	var cleaned_fls: Array[int] = [];
	while (s_index < h_starts.size()) || (e_index < h_ends.size()):
		var curr_start: int = 9223372036854775807 if s_index >= h_starts.size() else h_starts[s_index];
		var curr_end: int = 9223372036854775807 if e_index >= h_ends.size() else h_ends[e_index];
		if curr_start <= curr_end:
			s_index += 1;
			if layers == 0:
				cleaned_fls.append(curr_start);
			layers += 1;
		else:
			e_index += 1;
			layers -= 1;
			if layers == 0:
				cleaned_fls.append(curr_end);
	
	var is_highlighted: bool = false;
	var last: int = 0;
	var out_str: String = "";
	for r: int in cleaned_fls:
		out_str = out_str + (highlighted if is_highlighted else default) + text.substr(last,r-last);
		last = r;
		is_highlighted = !is_highlighted;
	out_str = out_str + (highlighted if is_highlighted else default) + text.substr(last);
	return out_str;

func clear_results() -> void:
	for c in self.warning_display.get_children():
		c.queue_free();
