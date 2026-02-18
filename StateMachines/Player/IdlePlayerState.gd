class_name IdlePlayerState extends PlayerState

func _ready() -> void:
	name = "idle"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	if p.sprite:
		p.sprite.play("idle")
		p.sword.play("idle")
		p.fx.play("idle")
	p.canCast = true

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	c.handle_input()
	c.handle_melee_attacks()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()
