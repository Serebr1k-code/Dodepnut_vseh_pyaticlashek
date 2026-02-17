extends CharacterBody2D

@export var sprite : AnimatedSprite2D

var state : String = "warning"

func _physics_process(delta: float) -> void:
	pass

func _on_damage_start_timer_timeout() -> void:
	state = "damage"
	sprite.play("damage")

func _on_spike_lifetime_timeout() -> void:
	$".".queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):
		if state == "damage":
			body.emit_signal("take_damage", 1)
