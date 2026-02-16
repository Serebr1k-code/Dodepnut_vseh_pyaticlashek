class_name LiberalFlyingEnemyState extends FlyingEnemyState

func _ready() -> void:
	name = "liberal"

func enter():
	#if e.sprite: e.sprite.play("idle")
	e.liberal_delay.start()
	e.liberal_move_delay.start()
	e.attack_swap.start()

func exit():
	e.liberal_delay.stop()
	e.attack_swap.stop()
	e.liberal_move_delay.stop()

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass

# стреляем раз за таймер
func _on_liberal_delay_timeout() -> void:
	if e.target:
		c.create_proj((e.target.global_position - e.global_position).angle())

# двигаемся раз за таймер
func _on_liberal_move_delay_timeout() -> void:
	if e.target:
		var target: Vector2 = e.target.global_position
		target.y -= e.height + randi_range(-e.height_rando, e.height_rando)
		target.x += randi_range(-e.left_right_rando, e.left_right_rando)
		c.go_to(target)
