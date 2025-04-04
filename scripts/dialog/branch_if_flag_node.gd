extends DialogTreeNode
class_name BranchIfFlagNode

@export var flag: StringName = "";
@export var _false: DialogTreeNode = null;
@export var _true: DialogTreeNode = null;

func has_next() -> bool:
	return self.next() != null;

func next() -> DialogTreeNode:
	if SaveState.get_flag(flag):
		return self._true;
	else:
		return self._false;

func get_text() -> String:
	return "";

func get_title() -> String:
	return "";
