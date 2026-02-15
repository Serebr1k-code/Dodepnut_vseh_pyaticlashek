class_name Attack1BossState extends State

@export var p: Boss
@export var c: BossController

const DEFAULT_ATTACK_COUNT := 40
const PROJECTILE_COUNT := 12
const PROJECTILE_SPAWN_DISTANCE := 50

var current_attack_count = DEFAULT_ATTACK_COUNT
var signal_emitted = false

func _ready() -> void:
	name = "attack1"

func enter():
	current_attack_count = DEFAULT_ATTACK_COUNT
	p.attack1Delay.start()	
	signal_emitted = false

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass

func _on_attack_1_delay_timeout() -> void:
	if current_attack_count == 0:
		if !signal_emitted:
			p.emit_signal("attack_end")
			signal_emitted = true
		return
	c.spawn_circle_of_projectiles(
		PROJECTILE_COUNT,
		PROJECTILE_SPAWN_DISTANCE,
		p.position,
		current_attack_count * 5
	)
	current_attack_count -= 1
	p.attack1Delay.start()
