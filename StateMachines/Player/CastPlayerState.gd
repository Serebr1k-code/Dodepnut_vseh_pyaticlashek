class_name CastPlayerState extends PlayerState

func _ready() -> void:
	name = "cast"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	if p.sprite: p.sprite.play("magic")
	p.canCast = false
	p.casting = true
	p.sprite.play("magic")
	p.magic_anim.start()
	p.velocity.x = 0

func exit():
	p.casting = false

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	c.handle_physics(delta)
