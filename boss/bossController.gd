class_name BossController extends Node

@export var b : Boss

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func spawn_circle_of_projectiles(count: int, projectile_spawn_distance: int, center: Vector2, deg_shift: float):
	for i in range(count):
		var p = b.bossProjectile.instantiate()
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
		
func spawn_circle_of_projectiles_with_hole(count: int, speed: int, projectile_spawn_distance: int, center: Vector2, deg_shift: float, be: float, le: float):
	for i in range(count):
		var deg = i * (360 / count)
		if (deg % 180 >= be and deg % 180 <= le): continue
		
		var p = b.bossProjectile.instantiate()
		get_parent().add_child(p) 
		p.projectileSpeed = speed

		var x_multiplier = sin(deg_to_rad(deg + deg_shift))
		var y_multiplier = cos(deg_to_rad(deg + deg_shift))

		p.position = Vector2(
			center.x + x_multiplier * projectile_spawn_distance,
			center.y + y_multiplier * projectile_spawn_distance
		)

		p.velocity = Vector2(
			x_multiplier * p.projectileSpeed,
			y_multiplier * p.projectileSpeed
		)
		
func spawn_spike_row(start: Vector2, count: int, distance: int):
	for i in range(count):
		var s = b.bossSpike.instantiate()
		get_parent().add_child(s)
		
		s.position = Vector2(
			start.x + i * distance, start.y
		)


func _on_boss_take_damage(recieved_damage: int) -> void:
	b.Health -= recieved_damage
	if b.Health <= 0:
		b.queue_free()
