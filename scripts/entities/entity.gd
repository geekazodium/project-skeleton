extends CharacterBody2D
class_name EntityBody

@export var move_speed: float = 20;
@export var friction: float = 9;

var stun_timer: float = 0;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.move_and_slide();
	#self.position += self.velocity * delta;
	self.velocity -= self.velocity * friction * delta;
	if stun_timer > 0.:
		self.stun_timer -= delta;

func move_in_direction(direction: Vector2, delta: float):
	if stun_timer > 0.:
		return;
	self.velocity += direction.normalized() * delta * move_speed;

func apply_knockback(knockback: Vector2):
	self.velocity = knockback;

func apply_stun(duration: float):
	self.stun_timer = duration;
