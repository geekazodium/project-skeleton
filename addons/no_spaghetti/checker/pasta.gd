@tool
extends Resource
class_name Pasta

## Pasta: a silly name I gave rulesets.
##
## A pasta is a ruleset for a specific file type.
##
## Pasta rules are RegEx(s) which will be checked
## against all files in the project
##
## You can define a custom pasta TODO: bother with this doc

@export var file_type: String = "gd";
@export var rule: String;
var _compiled_rule: RegEx = null;
@export var exceptions: Array[RuleException] = [];

func compile_rules() -> void:
	SpaghettiLogger.debug("compiled rule: {0}", [self.rule]);
	if self._compiled_rule == null || self._compiled_rule.get_pattern() != rule:
		self._compiled_rule = RegEx.create_from_string(self.rule);
	for e: RuleException in self.exceptions:
		e.compile_rules();

func search_all(text: String, array: Array[RegExMatch]) -> void:
	for res: RegExMatch in self._compiled_rule.search_all(text):
		if self._check_exempt(res):
			continue;
		array.append(res);

func _check_exempt(res: RegExMatch) -> bool:
	for e: RuleException in self.exceptions:
		if e.is_exempt(res):
			return true;
	return false;
