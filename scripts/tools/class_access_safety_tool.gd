@tool
extends Node;
class_name ClassAccessSafetyTool

var keybind_pressed: bool = false;
@export var buttons: Array[int] = [KEY_F,KEY_M];
@export var lint_type: String = "gd";
var safety_iter_limit: int = 100;

var no_private_access_rule: RegEx = RegEx.create_from_string("([_a-zA-Z0-9]+)[ \n\t]*\\.[ \n\t]*_.+");

func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		return;
	
	for keycode in buttons:
		if self.keybind_pressed == Input.is_key_pressed(keycode):
			return;
	
	self.keybind_pressed = !self.keybind_pressed;
	
	if !self.keybind_pressed:
		return;
	
	check_folder("res://");
	
	print_rich("[color=pink]the linting is completed! please check the warnings and please try to address them");


func check_folder(directory: String, layers: int = 64):
	
	var dir_access: DirAccess = DirAccess.open(directory);
	var files: PackedStringArray = dir_access.get_files();
	
	var parent_path: String = directory;
	if !directory.ends_with("/"):
		parent_path += "/";
	
	for f in files:
		if f.get_extension() != self.lint_type:
			continue;
		var file: FileAccess = FileAccess.open(parent_path + f,FileAccess.READ);
		self.check_file(file);
		file.close();
	
	if layers <= 0:
		push_warning("max depth reached, something may be wrong of max depth is not set properly.");
		return;
	
	var directories: PackedStringArray = dir_access.get_directories();
	
	for dir in directories:
		check_folder(parent_path + dir, layers - 1);

func check_file(file: FileAccess):
	if self.get_script().get_path() == file.get_path():
		return;
	
	var text: String = file.get_as_text();
	var printed: bool = false;
	
	var results: Array[RegExMatch] = no_private_access_rule.search_all(text);
	
	results = results.filter(filter_self_ref);
	
	if results.size() > 0:
		print_rich("\n[color=white]matches in: "+file.get_path());
		
	for r in results:
		self.print_match(text,r);

func filter_self_ref(result: RegExMatch) -> bool:
	return result.get_string(1) != "self" && result.get_string(1) != "_self"

func print_match(string: String,result: RegExMatch, context_size: int = 30):
	var start = result.get_start();
	var end = result.get_end();
	print_rich(
		"\n[color=gray]......"+string.substr(start-context_size, context_size)+
		"[color=orange]"+result.get_string()+
		"[color=gray]"+string.substr(end, context_size) +"......\n"
		);
