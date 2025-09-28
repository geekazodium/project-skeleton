@tool
extends Node
class_name SpaghettiChecker

const ignore_file: String = ".nsignore"
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


func check_folder(directory: String, layers: int = 64, ignores: PackedStringArray = []) -> int:
	var dir_access: DirAccess = DirAccess.open(directory);
	dir_access.include_hidden = true;
	var files: PackedStringArray = dir_access.get_files();
	
	var parent_path: String = directory;
	if !directory.ends_with("/"):
		parent_path += "/";
	
	var matches: int = 0;
	var new_ignores: PackedStringArray = ignores;
	if files.has(self.ignore_file):
		new_ignores = self.get_ignores(parent_path,self.ignore_file);
		new_ignores.append_array(ignores);
	
	for f in files:
		if self.is_ignored(parent_path + f, ignores):
			continue;
		matches += self.check_file(parent_path + f);
	
	if layers <= 0:
		SpaghettiLogger.warning("max depth reached, something may be wrong of max depth is not set properly.");
		return matches;
	
	var directories: PackedStringArray = dir_access.get_directories();
	
	for dir in directories:
		matches += self.check_folder(parent_path + dir, layers - 1, new_ignores);
	
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

## parses ignore file in path {rf}{file_name}, prepending {rf} to all
## entries
func get_ignores(rf: String, file_name: String) -> PackedStringArray:
	var file_path_string: String = rf + file_name;
	var file: FileAccess = FileAccess.open(file_path_string,FileAccess.READ);
	
	var ignores: PackedStringArray = [];
	
	var text: String = file.get_as_text();
	for line in text.split("\n"):
		line = line.strip_edges();
		if line.begins_with("#") || line.length() == 0:
			line = file.get_line();
			continue;
		ignores.append(rf+line);
	
	return ignores;

## check if a file path matches any of the ignored file paths in ignored array
## TRAILING CHARACTERS ARE ALL ALLOWED AS LONG AS STRING STARTS WITH PATTERN
func is_ignored(file_path: String, ignored: PackedStringArray) -> bool:
	for i: String in ignored:
		if file_path.match(i+"*"):
			return true;
	return false;
