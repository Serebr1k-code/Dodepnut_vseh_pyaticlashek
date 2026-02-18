class_name Attack3BossState extends State

@export var b: Boss
@export var c: BossController

var current_attack_count
var signal_emitted = false
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	name = "attack3"
	if b:
		current_attack_count = b.default_attack_count3
	
func enter():
	current_attack_count = b.default_attack_count3
	b.attack3Delay.start()	
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
			b.emit_signal("attack_end")
			signal_emitted = true
			b.attack3Delay.stop()
		return
	
	c.spawn_spike_row(
		Vector2(-(b.spike_count3 * 0.5 * b.spike_spawn_distance3) + randi() % int(b.spike_spawn_distance3), 200), 
		b.spike_count3, 
		b.spike_spawn_distance3
	)
	
	current_attack_count -= 1
	b.attack2Delay.start()
