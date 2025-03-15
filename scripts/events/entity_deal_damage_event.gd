extends Object
class_name EntityDealDamageEvent

var entity: PhysicsBody2D = null;
var damage_source: Node2D = null;
var damage: float = 0;
var _canceled: bool = false;
var _multiplier: float = 1;

@warning_ignore("shadowed_variable")
static func new_inst(damage_source: Node2D, entity: PhysicsBody2D, damage: float) -> EntityDealDamageEvent:
	var _self: EntityDealDamageEvent = EntityDealDamageEvent.new();
	_self.entity = entity;
	_self.damage_source = damage_source;
	_self.damage = damage;
	return _self;

func set_canceled(canceled: bool):
	self._canceled = canceled;

func add_multiplier(amount: float):
	self._multiplier += amount;

func get_entity() -> PhysicsBody2D:
	return self.entity;
	
func is_canceled() -> bool:
	return self._canceled;

func get_damage() -> float:
	return self.damage;
	
func get_damage_source() -> Node2D:
	return self.damage_source;

func add_damage(amount: float):
	self.damage += amount;

func get_final_damage() -> float:
	return self.damage * self._multiplier;
