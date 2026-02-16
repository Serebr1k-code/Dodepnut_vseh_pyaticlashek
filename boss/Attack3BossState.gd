class_name Attack3BossState extends State

@export var boss: Boss
@export var controller: BossController

@export var default_attack_count : int
@export var spike_spawn_distance : int
@export var spike_count : int

var current_attack_count = default_attack_count
var signal_emitted = false
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	name = "attack3"
	
func enter():
	current_attack_count = default_attack_count
	boss.attack3Delay.start()	
	signal_emitted = false
	
func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass

func _on_attack_3_delay_timeout() -> void:
	if current_attack_count <= 0:
		if !signal_emitted:
			boss.emit_signal("attack_end")
			signal_emitted = true
			boss.attack3Delay.stop()
		return
	
	controller.spawn_spike_row(
		Vector2(-(spike_count * 0.5 * spike_spawn_distance) + rng.randi() % spike_spawn_distance, 200), 
		spike_count, 
		spike_spawn_distance
	)
	
	current_attack_count -= 1
	boss.attack2Delay.start()
