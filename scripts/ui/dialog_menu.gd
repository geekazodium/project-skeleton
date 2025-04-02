extends VBoxContainer
class_name DialogMenu

@export var title_box: Label = null;
@export var text_box: Label = null;

func _ready() -> void:
	EventBus.ui_dialog_show_next.connect(self.on_show_next);

func next_pressed() -> void:
	self.visible = false;
	var clicked_event = DialogNextClickedEvent.new_inst();
	EventBus.ui_dialog_next_clicked.emit(clicked_event)
	clicked_event.free();

func on_show_next(node: DialogTreeNode):
	self.title_box.text = node.get_title();
	self.text_box.text = node.get_text();
	self.visible = true;
