extends ShapeCast2D

@export var damage: float = 0;
@export var damage_event: StringName = "";

func get_move_speed() -> float:
	return 300;

func _physics_process(delta: float) -> void:
	self.position += Vector2.RIGHT.rotated(self.global_rotation) * delta * self.get_move_speed();
	self.target_position = Vector2i.RIGHT * self.get_move_speed() * delta;
	self.force_shapecast_update();
	if self.is_colliding():
		var colliding: EntityBody = self.get_collider(0) as EntityBody;
		if colliding != null:
			self.target_collide_damage(colliding);
		self.queue_free();


func target_collide_damage(target: Node2D) -> bool:
	var event: EntityDealDamageEvent = EntityDealDamageEvent.new_inst(self,target,damage);
	if damage_event != "":
		EventBus.emit_signal(damage_event,event);
	
	if !event.is_canceled():
		var hit: HealthTracker = target.get_node(HealthTracker.default_path);
		hit.change_health(-event.get_final_damage());
	
	var canceled: bool = event.is_canceled();
	event.free();
	return !canceled;
