extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.player_dead.connect(self.on_player_death);

func on_player_death(event: EntityDeathEvent):
	self.visible = true;

func _on_respawn_button_pressed() -> void:
	self.get_tree().change_scene_to_file("res://scenes/game_scene.tscn");
