class_name Projectile extends CharacterBody2D

@onready var projectile_scene = preload("res://player/projectile.tscn")

func _process(delta: float) -> void:
	velocity *= 0.95
	if velocity.round() == Vector2.ZERO:
		var proj : Dictionary [int, Projectile] = {}
		for i in range(0, 2):
			proj[i] = projectile_scene.instantiate()
			proj[i].velocity = Vector2(randi_range(-200, 200), randi_range(-200, 200))
			proj[i].position = global_position
		for i in range(0, 2):
			get_parent().add_child(proj[i])
		$".".queue_free()
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	$".".queue_free()
