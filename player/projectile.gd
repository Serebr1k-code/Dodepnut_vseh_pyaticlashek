class_name Projectile extends CharacterBody2D

@onready var projectile_scene = preload("res://player/projectile.tscn")

var damage := 0
var fromPlayer := false # так как есть только вражеские и снаряды игрока, я решил сделать всё в 1 сцене

func _process(delta: float) -> void:
	if velocity.round() == Vector2.ZERO:
		$".".queue_free()
func _physics_process(delta: float) -> void:
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if fromPlayer: return # поэтому тут есть пара проверок
		if body.is_invincible: # на зато не надо делать 50 сцен
			$".".queue_free() # надо кстати тут конфиг сделать ему, чтобы патерны были веселые
			return # к примеру самонаводка или сдвиг
	if not body.is_in_group("Player") and not fromPlayer and body.is_in_group("HaveHealth"): return
	if damage and body.is_in_group("HaveHealth"):
		body.take_damage.emit(damage)
	$".".queue_free()
