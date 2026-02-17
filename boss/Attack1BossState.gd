class_name Attack1BossState extends State

@export var p: Boss
@export var c: BossController

@export var default_attack_count : int
@export var projectile_count : int
@export var projectile_spawn_distance : int
@export var attack_rotation : int

var current_attack_count = default_attack_count
var signal_emitted = false
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	name = "attack1"
	
func enter():
	current_attack_count = default_attack_count
	p.attack1Delay.start()	
	signal_emitted = false
	
	if rng.randi() % 2 == 1:
		attack_rotation *= -1

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass

func _on_attack_1_delay_timeout() -> void:
	if current_attack_count <= 0:
		if !signal_emitted:
			p.emit_signal("attack_end")
			signal_emitted = true
			p.attack1Delay.stop()
		return
		
	c.spawn_circle_of_projectiles(
		projectile_count,
		projectile_spawn_distance,
		Vector2(0, 0),
		attack_rotation * (default_attack_count - current_attack_count)
	)
	current_attack_count -= 1
	p.attack1Delay.start()
