extends Node
class_name HealthTracker

@export var health: float = 10;
@export var max_health: float = 10;
@export var change_per_second: float = 0;
@export var death_event: String = "";

signal health_changed(current:float);
signal death(event: EntityDeathEvent);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.health_changed.emit(self.health);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.change_health(delta * change_per_second);

## use this function to change the health of the entity.
func change_health(amount: float):
	self.health += amount;
	self.health_changed.emit(self.health);
	if self.health <= 0.:
		self.on_death();

## this function is called when the entity's health changes and drops to zero or less.
## checks if node is already queued for deletion to prevent multiple death events of one entity.
## use the EntityDeathEvent to interact with this
func on_death():
	if self.get_parent().is_queued_for_deletion():
		return;
	var event = EntityDeathEvent.new_inst(self.get_parent());
	self.death.emit(event);
	
	if self.death_event.length() != 0:
		EventBus.emit_signal(death_event,event);
	
	if !event.is_canceled():
		self.get_parent().queue_free();
	event.free();

func add_max_health(amount: float):
	self.health += amount;
	self.max_health += amount;
	self.health_changed.emit(self.health);

static var default_path: String = "HealthTracker";
