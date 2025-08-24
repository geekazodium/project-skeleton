extends Node

@export var effect_types: Dictionary = {};

func _ready() -> void:
	self.register_effect_type(preload("res://assets/status_effects/deaths_door.tres"));

func register_effect_type(status_effect: StatusEffect) -> void:
	self.effect_types[status_effect.get_effect_name()] = status_effect;

func update(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].update(character_body, stacks);

func emit_effect_fist_added(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_initial_apply(character_body,stacks);
	
func emit_effect_added(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_apply(character_body,stacks);

func emit_effect_final_removed(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_final_removed(character_body,stacks);
	
func emit_effect_removed(character_body: EntityBody, key: StringName, stacks: int) -> void:
	self.effect_types[key].on_removed(character_body,stacks);
