@tool
extends Resource
class_name SpaghettiSettings

const IGNORED_STRINGS: String = "no_spaghetti/ignores";
const RULES_SRC: String = "no_spaghetti/rules_src";

static var settings: Array[Dictionary] = [
	{
		"default": "res://pasta_rules/",
		"name": RULES_SRC,
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_DIR,
		"description": "This is the directory where no_spaghetti will read the ignored file list"
	},
	{
		"default": ["res://addons/"],
		"name": IGNORED_STRINGS,
		"type": TYPE_ARRAY,
		"hint": PROPERTY_HINT_ARRAY_TYPE,
		"hint_string": ("%d:" % [TYPE_STRING]),
		"description": "Ignored strings"
	}
];

static func register_properties() -> void:
	for p: Dictionary in settings:
		if !ProjectSettings.has_setting(p.get("name")):
			ProjectSettings.set(p.get("name"), p.get("default"));
		ProjectSettings.set_initial_value(p.get("name"), p.get("default"));
		ProjectSettings.add_property_info(p);
