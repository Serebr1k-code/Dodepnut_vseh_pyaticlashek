class_name MovePlayerState extends PlayerState

func _ready() -> void:
	name = "move"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	if p.sprite and !p.dashing: p.sprite.play("run")
	if p.sprite and p.dashing: p.sprite.play("dash")

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if p.dashing:
		p.sprite.play("dash")
	else:
		p.sprite.play("run")
	c.handle_input()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()
