@tool
extends Pasta

# MIT License (c) 2025 geekazodium

var compiled: RegEx;

func is_covered(file_name: String) -> bool:
	return file_name.get_extension() == "tscn";

func compile_rules() -> void:
	self.compiled = RegEx.create_from_string("\\[sub_resource type=\"GDScript\" id=\".*\"\\]");
	
func search_all(text: String, file_name: String, array: Array[RegExMatch]) -> void:
	for m: RegExMatch in self.compiled.search_all(text):
		array.append(m);
