class_name Projectile extends CharacterBody2D

@onready var projectile_scene = preload("res://player/projectile.tscn")

var damage := 0
var fromPlayer := false

func _process(delta: float) -> void:
	velocity *= 1.05
	if velocity.round() == Vector2.ZERO:
		$".".queue_free()
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and fromPlayer: return
	if not body.is_in_group("Player") and not fromPlayer and body.is_in_group("HaveHealth"): return
	if damage and body.is_in_group("HaveHealth"):
		body.take_damage.emit(damage)
	$".".queue_free()
