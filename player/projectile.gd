class_name Projectile extends CharacterBody2D

@onready var projectile_scene = preload("res://player/projectile.tscn")

func _process(delta: float) -> void:
	velocity *= 1.05
	if velocity.round() == Vector2.ZERO:
		$".".queue_free()
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	$".".queue_free()
