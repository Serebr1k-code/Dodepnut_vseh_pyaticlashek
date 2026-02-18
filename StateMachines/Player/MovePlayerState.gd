class_name MovePlayerState extends PlayerState

func _ready() -> void:
	name = "move"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	if p.dashing:
		p.sprite.play("dash")
		p.sword.play("dash")
		p.fx.play("dash")
	else:
		p.sprite.play("run")
		p.sword.play("run")
		p.fx.play("run")
	p.canCast = true

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if p.dashing:
		p.sprite.play("dash")
		p.sword.play("dash")
		p.fx.play("dash")
	else:
		p.sprite.play("run")
		p.sword.play("run")
		p.fx.play("run")
	c.handle_input()
	c.handle_melee_attacks()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()
