@tool
extends Pasta

# MIT License (c) 2025 geekazodium

var compiled: RegEx;
var exception: RuleException;

func compile_rules() -> void:
	self.compiled = RegEx.create_from_string("([_a-zA-Z0-9]+)[ \n\t]*\\.[ \n\t]*_.+");
	if self.exception == null:
		self.exception = RuleException.new();
		self.exception.rule = "^_?self$";
		self.exception.group = 1;
	self.exception.compile_rules();
	
func search_all(text: String, file_name: String, array: Array[RegExMatch]) -> void:
	for m: RegExMatch in self.compiled.search_all(text):
		if self.exception.is_exempt(m):
			continue;
		array.append(m);
