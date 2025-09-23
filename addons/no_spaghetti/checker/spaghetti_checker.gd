@tool
extends Node
class_name SpaghettiChecker

var keybind_pressed: bool = false;
@export var buttons: Array[int] = [KEY_F,KEY_M];
@export var lint_type: String = "gd";
var safety_iter_limit: int = 128;

@export var pastas: Array[Pasta] = [];

func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		return;
	
	for keycode in buttons:
		if self.keybind_pressed == Input.is_key_pressed(keycode):
			return;
	
	self.keybind_pressed = !self.keybind_pressed;
	
	if !self.keybind_pressed:
		return;
	
	self.check_program();

func check_program() -> void:
	for pasta in self.pastas:
		pasta.compile_rules();
	
	var count: int = self.check_folder("res://");
	if count > 0:
		print_rich("[color=yellow]warnings generated: "+String.num_int64(count));
	else:
		print_rich("[color=green]all clean!");
	
	print_rich("[color=pink]the linting is completed! please check the warnings and please try to address them");


func check_folder(directory: String, layers: int = 64) -> int:
	
	var dir_access: DirAccess = DirAccess.open(directory);
	var files: PackedStringArray = dir_access.get_files();
	
	var parent_path: String = directory;
	if !directory.ends_with("/"):
		parent_path += "/";
	
	var matches: int = 0;
	
	for f in files:
		matches += self.check_file(parent_path + f);
	
	if layers <= 0:
		SpaghettiLogger.warning("max depth reached, something may be wrong of max depth is not set properly.");
		return matches;
	
	var directories: PackedStringArray = dir_access.get_directories();
	
	for dir in directories:
		matches += self.check_folder(parent_path + dir, layers - 1);
	
	return matches;

func check_file(file_path_string: String) -> int:
	var file: FileAccess = FileAccess.open(file_path_string,FileAccess.READ);
	
	var text: String;
	var parsed: bool = false;
	
	var results: Array[RegExMatch] = [];
	for pasta in self.pastas:
		if file_path_string.get_extension() != pasta.file_type:
			continue;
		if !parsed:
			text = file.get_as_text();
			parsed = true;
		pasta.search_all(text, results);
	#
	#results = results.filter(filter_self_ref);
	
	if results.size() > 0:
		print_rich("\n[color=white]matches in: "+file.get_path());
		
	for r in results:
		self.print_match(text,r);
	
	file.close();
	return results.size();
#
#func filter_self_ref(result: RegExMatch) -> bool:
	#return result.get_string(1) != "self" && result.get_string(1) != "_self"

func print_match(string: String,result: RegExMatch, context_size: int = 70):
	var start = result.get_start();
	var end = result.get_end();
	print_rich(
		"\n[color=gray]......"+string.substr(start-context_size, context_size)+
		"[color=orange]"+result.get_string()+
		"[color=gray]"+string.substr(end, context_size) +"......\n"
		);
