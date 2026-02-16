class_name Attack2BossState extends State

@export var boss: Boss
@export var c: BossController

@export var default_attack_count : int
@export var projectile_count : int
@export var projectile_spawn_distance : int
@export var attack_rotation : int
@export var hole_size : int
@export var max_hole_step : int
@export var projectile_speed : int 

var rng := RandomNumberGenerator.new()
var current_attack_count := default_attack_count
var current_hole_position := rng.randi() % (180 - hole_size)
var signal_emitted = false

func _ready() -> void:
	name = "attack2"
	
func enter():
	current_attack_count = default_attack_count
	current_hole_position = rng.randi() % (180 - hole_size)
	signal_emitted = false
	boss.attack2Delay.start()
	
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

func _on_attack_2_delay_timeout() -> void:
	if current_attack_count <= 0:
		if !signal_emitted:
			boss.emit_signal("attack_end")
			signal_emitted = true
			boss.attack2Delay.stop()
		return
	
	c.spawn_circle_of_projectiles_with_hole(
		projectile_count, projectile_speed,
		projectile_spawn_distance,
		Vector2(0, 0),
		attack_rotation * (default_attack_count - current_attack_count),
		current_hole_position,
		current_hole_position + hole_size
	)
	
	var hole_step := rng.randi() % (max_hole_step / 2) + (max_hole_step / 2)
	hole_step *= 1 if (rng.randi() % 2 == 1) else -1
	if current_hole_position + hole_step < 0:
		current_hole_position -= hole_step
	elif current_hole_position + hole_step > 180 - hole_size:
		current_hole_position -= hole_step
	else:
		current_hole_position += hole_step
	
	current_attack_count -= 1
	boss.attack2Delay.start()
