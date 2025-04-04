extends Node

@export var root: DialogTreeNode = null;

var current_node: DialogTreeNode = null;

func _ready() -> void:
	self.current_node = self.root;
	EventBus.ui_dialog_next_clicked.connect(self.next_node);
	EventBus.ui_dialog_show_next.emit(self.current_node);

func next_node(_event: DialogNextClickedEvent):
	if self.current_node.has_next():
		self.current_node = self.current_node.next();
	if self.current_node == null:
		return;
	if self.current_node.skip_self():
		self.next_node(null);
		return;
	EventBus.ui_dialog_show_next.emit(self.current_node);
