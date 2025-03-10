extends Object
class_name EntityDealDamageEvent

var entity: PhysicsBody2D = null;
var damage_source: Node2D = null;
var damage: float = 0;
var canceled: bool = false;

@warning_ignore("shadowed_variable")
static func new_inst(damage_source: Node2D, entity: PhysicsBody2D, damage: float) -> EntityDealDamageEvent:
	var _self: EntityDealDamageEvent = EntityDealDamageEvent.new();
	_self.entity = entity;
	_self.damage_source = damage_source;
	_self.damage = damage;
	return _self;

@warning_ignore("shadowed_variable")
func set_canceled(canceled: bool):
	self.canceled = canceled;

func get_entity() -> PhysicsBody2D:
	return self.entity;
	
func is_canceled() -> bool:
	return self.canceled;

func get_damage() -> float:
	return self.damage;
	
func get_damage_source() -> Node2D:
	return self.damage_source;

func add_damage(amount: float):
	self.damage += amount;
