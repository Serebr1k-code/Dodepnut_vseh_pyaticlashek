class_name AirbornePlayerState extends PlayerState

func _ready() -> void:
	name = "airborne"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	if p.sprite: p.sprite.play("idle")

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if p.dashing:
		p.sprite.play("dash")
	else:
		p.sprite.play("idle")
	c.handle_input()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
