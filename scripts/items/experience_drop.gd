extends Area2D

var tween_to: Node2D = null;
var tween_timer: float = 0.;

var alive_timer: float = 200;

@export var tween_velocity = 5;
@export var distance_tolerance = 50;

func _ready() -> void:
	var sprite: Sprite2D = $ExperienceDropSprite;
	var tween: Tween = sprite.create_tween();
	tween.tween_property(sprite, "position", Vector2.UP * 15, .5).set_ease(Tween.EASE_IN_OUT);
	tween.tween_property(sprite, "position", Vector2.ZERO, .6).set_ease(Tween.EASE_IN_OUT);
	tween.set_loops();
	tween.play();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.alive_timer -= delta;
	if alive_timer <= 0:
		self.queue_free();
		return;
	
	if tween_to == null:
		return;
	var target_position = tween_to.position;
	var scale_fac: float = 1.-pow(FollowCamera2D.EULER_CONST,-delta * self.tween_velocity);
	var move_by: Vector2 = (target_position - self.global_position) * scale_fac;
	self.position = self.position + move_by;
	if (self.position - tween_to.position).length_squared() < distance_tolerance * distance_tolerance:
		ExperienceTracker.find_node(tween_to).gain_xp(1);
		self.queue_free();

func _on_body_entered(body: Node2D) -> void:
	self.tween_to = body;
