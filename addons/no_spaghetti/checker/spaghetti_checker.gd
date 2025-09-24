@tool
extends Node
class_name SpaghettiChecker

var safety_iter_limit: int = 128;
@export var pastas: Array[Pasta] = [];

signal lint_warnings_generated(path: String, text: String, results: Array[RegExMatch]);

func add_pasta(pasta: Pasta) -> void:
	self.pastas.append(pasta);

func check_program() -> void:
	for pasta in self.pastas:
		pasta.compile_rules();
	
	var count: int = self.check_folder("res://");
	if count > 0:
		SpaghettiLogger.rich("[color=yellow]warnings generated: "+String.num_int64(count));
	else:
		SpaghettiLogger.rich("[color=green]all clean!");
	
	SpaghettiLogger.rich("[color=pink]the linting is completed!");


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
	
	if results.size() > 0:
		self.lint_warnings_generated.emit(file.get_path(), text, results);
	file.close();
	return results.size();
