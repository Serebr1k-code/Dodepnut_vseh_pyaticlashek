class_name AirbornePlayerState extends PlayerState

func _ready() -> void:
	name = "airborne"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	p.sprite.play("idle")
	p.sword.play("idle")
	p.fx.play("idle")
	p.canCast = false

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if Input.is_action_just_pressed("Jump") and p.fly_time > 0:
		state_machine.change_state("fly")
	if p.dashing:
		p.sprite.play("dash")
	else:
		p.sprite.play("idle")
	c.handle_input()
	c.handle_melee_attacks()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
