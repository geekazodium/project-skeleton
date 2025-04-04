extends Resource
class_name DialogTreeNode

func has_next() -> bool:
	return false;

func skip_self() -> bool:
	return true;

func next() -> DialogTreeNode:
	push_error("no next node set!");
	return null;

func get_text() -> String:
	return "placeholder";

func get_title() -> String:
	return "placeholder";
