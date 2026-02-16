class_name DashFlyingEnemyState extends FlyingEnemyState

func _ready() -> void:
	name = "dash"

func enter():
	#if e.sprite: e.sprite.play("idle")
	c.go_to(e.target.global_position)
	e.dash_repeat_delay.start()
	e.attack_swap.start()

func exit():
	e.dash_repeat_delay.stop()
	e.attack_swap.stop()

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass


func _on_dash_repeat_delay_timeout() -> void:
	c.go_to(e.target.global_position)
