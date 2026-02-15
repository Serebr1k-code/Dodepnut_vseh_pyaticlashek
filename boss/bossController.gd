class_name BossController extends Node

@export var boss : Boss

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func spawn_circle_of_projectiles(count: int, projectile_spawn_distance: int, center: Vector2, deg_shift: float):
	for i in range(count):
		var p = boss.bossProjectile.instantiate()
		get_parent().add_child(p) 

		var x_multiplier = sin(deg_to_rad(i * (360 / count) + deg_shift))
		var y_multiplier = cos(deg_to_rad(i * (360 / count) + deg_shift))

		p.position = Vector2(
			center.x + x_multiplier * projectile_spawn_distance,
			center.y + y_multiplier * projectile_spawn_distance
		)

		p.velocity = Vector2(
			x_multiplier * p.projectileSpeed,
			y_multiplier * p.projectileSpeed
		)
