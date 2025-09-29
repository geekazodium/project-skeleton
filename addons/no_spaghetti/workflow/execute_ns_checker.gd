extends Node2D

var output: FileAccess;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ns_checker: SpaghettiChecker = SpaghettiChecker.new();
	SpaghettiSettings.register_properties();
	ns_checker.load_rules(ProjectSettings.get_setting(SpaghettiSettings.RULES_SRC));
	ns_checker.lint_warnings_generated.connect(self.write_warning_to_file);
	ns_checker.check_program();
	if self.output != null:
		self.output.close();
	
func write_warning_to_file(path: String, text: String, results: Array[RegExMatch]) -> void:
	var converted_res: Array[Array] = [];
	for r: RegExMatch in results:
		converted_res.append([r.get_start(), r.get_end()]);
	self.write_output(JSON.stringify([path, converted_res]));

func write_output(line: String) -> void:
	if self.output == null:
		self.output = FileAccess.open("res://warnings_compact.txt",FileAccess.WRITE);
	self.output.store_line(line);
