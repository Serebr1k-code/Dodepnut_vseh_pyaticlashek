class_name FlyPlayerState extends PlayerState

func _ready() -> void:
	name = "fly"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	p.sprite.play("idle")
	p.sword.play("idle")
	p.fx.play("idle")
	p.left_fly_particles.emitting = true
	p.right_fly_particles.emitting = true
	p.canCast = false
	p.canDash = true

func exit():
	p.left_fly_particles.emitting = false
	p.right_fly_particles.emitting = false

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if p.dashing:
		p.sprite.play("dash")
	else:
		p.sprite.play("idle")
	if p.fly_time > 0:
		p.fly_time -= delta
		p.hud.update_fly(p.fly_time)
	c.handle_input()
	c.handle_melee_attacks()

func update_physics(delta: float):
	if p.fly_time > 0 and Input.is_action_pressed("Jump"):
		p.velocity.y = move_toward(p.velocity.y, p.WINGS_VELOCITY, 50)
	else:
		state_machine.change_state("airborne")
	c.handle_physics(delta)
	c.handle_movement()
