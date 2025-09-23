@tool
extends Resource
class_name RuleException

@export var group: int = 0;
@export var rule: String;
var _compiled_rule: RegEx = null;

func compile_rules() -> void:
	SpaghettiLogger.debug("compiled rule exemption: {0}", [self.rule]);
	if self._compiled_rule == null || self._compiled_rule.get_pattern() != rule:
		self._compiled_rule = RegEx.create_from_string(self.rule);

func is_exempt(regex_match: RegExMatch) -> bool:
	var string: String = regex_match.get_string(self.group);
	return self._compiled_rule.search(string) != null;
