class_name IdlePlayerState extends PlayerState

func _ready() -> void:
	name = "idle"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	pass

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	c.handle_input()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()
