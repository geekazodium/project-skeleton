@tool
extends Node
class_name SpaghettiChecker

var safety_iter_limit: int = 128;
@export var pastas: Array[Pasta] = [];

signal lint_warnings_generated(path: String, text: String, results: Array[RegExMatch]);

func load_rules(path: String) -> void:
	SpaghettiLogger.debug("loading rules from {0}", [path]);
	self.import_folder(path);

func import_folder(directory: String, layers: int = self.safety_iter_limit) -> int:
	var dir_access: DirAccess = DirAccess.open(directory);
	if dir_access == null:
		SpaghettiLogger.error("failed to access directory {0}", [directory]);
		return 0;
	dir_access.include_hidden = true;
	var files: PackedStringArray = dir_access.get_files();
	
	var parent_path: String = directory;
	if !directory.ends_with("/"):
		parent_path += "/";
	
	var import_count: int = 0;
	
	for f in files:
		if f.get_extension() == "gd":
			self.load_rule(parent_path + f);
	
	if layers <= 0:
		SpaghettiLogger.warning("max depth reached, something may be wrong of max depth is not set properly.");
		return import_count;
	
	var directories: PackedStringArray = dir_access.get_directories();
	
	for dir in directories:
		import_count += self.import_folder(parent_path + dir, layers - 1);
	
	return import_count;

func load_rule(path: String) -> bool:
	var script: Script = load(path) as Script;
	if script == null:
		SpaghettiLogger.warning("script not found at path {0}", [path]);
		return false;
	var res: Resource = Resource.new();
	res.set_script(script);
	var pasta: Pasta = res as Pasta;
	if pasta != null:
		SpaghettiLogger.debug("loading in pasta {0}", [path]);
		self.add_pasta(pasta);
		return true;
	
	SpaghettiLogger.warning("failed to load script as pasta! {0}", [path]);
	res.free();
	return false;

func add_pasta(pasta: Pasta) -> void:
	self.pastas.append(pasta);

func check_program() -> void:
	for pasta in self.pastas:
		SpaghettiLogger.debug("compiling rule: {0}", [pasta.get_script().resource_path]);
		pasta.compile_rules();
	
	var ignores: Array = ProjectSettings.get_setting(SpaghettiSettings.IGNORED_STRINGS);
	var count: int = self.check_folder("res://",self.safety_iter_limit,PackedStringArray(ignores));
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
	
	for f in files:
		if self.is_ignored(parent_path + f, ignores):
			continue;
		matches += self.check_file(parent_path + f);
	
	if layers <= 0:
		SpaghettiLogger.warning("max depth reached, something may be wrong of max depth is not set properly.");
		return matches;
	
	var directories: PackedStringArray = dir_access.get_directories();
	
	for dir in directories:
		matches += self.check_folder(parent_path + dir, layers - 1, ignores);
	
	return matches;

func check_file(file_path_string: String) -> int:
	var text: String = "";
	var parsed: bool = false;
	
	var results: Array[RegExMatch] = [];
	for pasta in self.pastas:
		if !pasta.is_covered(file_path_string):
			continue;
		if !parsed && !pasta.only_filename():
			var file: FileAccess = FileAccess.open(file_path_string,FileAccess.READ);
			text = file.get_as_text();
			file.close();
			parsed = true;
		var read_text = "" if pasta.only_filename() else text; 
		pasta.search_all(read_text, file_path_string, results);
	
	if results.size() > 0:
		self.lint_warnings_generated.emit(file_path_string, text, results);

	return results.size();

## check if a file path matches any of the ignored file paths in ignored array
## TRAILING CHARACTERS ARE ALL ALLOWED AS LONG AS STRING STARTS WITH PATTERN
func is_ignored(file_path: String, ignored: PackedStringArray) -> bool:
	for i: String in ignored:
		if file_path.match(i+"*"):
			return true;
	return false;
