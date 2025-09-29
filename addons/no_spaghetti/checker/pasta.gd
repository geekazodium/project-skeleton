@tool
extends Resource
class_name Pasta

## Pasta: a silly name I gave rulesets.
##
## A pasta is a parent type for all rulesets
## A ruleset has 3 basic commands: compile, is_covered and search_all
##
## search all allows you to append ruleset results to the inputted array.
##
## use the below template to create an inheriting script:

#@tool
#extends Pasta
#
#func is_covered(file_name: String) -> bool:
#	return false;
#func only_filename() -> bool:
#	return false;
#
#func compile_rules() -> void:
#	pass
#func search_all(text: String, array: Array[RegExMatch]) -> void:
#	pass

func only_filename() -> bool:
	return false;

func is_covered(file_name: String) -> bool:
	return file_name.get_extension() == "gd";

func compile_rules() -> void:
	SpaghettiLogger.warning("no compile_rules method defined for {0}",[self.get_script().resource_path]);

func search_all(text: String, file_name: String, array: Array[RegExMatch]) -> void:
	SpaghettiLogger.error("no search_all method defined for {0}",[self.get_script().resource_path]);
