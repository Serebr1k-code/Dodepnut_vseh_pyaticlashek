class_name BossProjectile extends CharacterBody2D

@onready var projectile_scene = preload("res://player/projectile.tscn")

var projectileSpeed = 400

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_lifetime_timeout() -> void:
	$".".queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_of(body, Player):
		body.emit_signal("take_damage", 1)
	$".".queue_free()
