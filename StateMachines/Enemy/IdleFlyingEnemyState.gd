class_name IdleFlyingEnemyState extends FlyingEnemyState

func _ready() -> void:
	name = "idle"

func enter():
	#if e.sprite: e.sprite.play("idle")
	pass

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass
