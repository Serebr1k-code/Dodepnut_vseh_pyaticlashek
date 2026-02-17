class_name MeleeAttackPlayerState extends PlayerState

func _ready() -> void:
	name = "melee_attack"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	p.attacking = true

func exit():
	p.attacking = false

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	c.handle_physics(delta)
