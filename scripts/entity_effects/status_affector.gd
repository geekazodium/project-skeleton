extends Node

@export var effect_types: Dictionary = {};

func _ready() -> void:
	self.register_effect_type(preload("res://assets/status_effects/deaths_door.tres"));

func register_effect_type(status_effect: StatusEffect) -> void:
	self.effect_types[status_effect.get_effect_name()] = status_effect;

func update(delta: float, status_tracker: StatusTracker, key: StringName, stacks: int) -> void:
	self.effect_types[key].update(delta,status_tracker, stacks);

func emit_effect_first_added(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_initial_apply(character_body,stacks);
	
func emit_effect_added(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_apply(character_body,stacks);

func emit_effect_final_removed(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_final_remove(character_body,stacks);
	
func emit_effect_removed(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_remove(character_body,stacks);
