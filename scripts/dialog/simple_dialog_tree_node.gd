extends DialogTreeNode
class_name SimpleDialogTreeNode

@export var _next: DialogTreeNode = null;
@export var text: String = "";
@export var title: String = "";

func has_next() -> bool:
	return self.next != null;

func skip_self() -> bool:
	return false;

func next() -> DialogTreeNode:
	return self._next;

func get_text() -> String:
	return self.text;

func get_title() -> String:
	return self.title;
