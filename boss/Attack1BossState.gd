class_name Attack1BossState extends State

@export var b: Boss
@export var c: BossController

var current_attack_count
var signal_emitted = false

func _ready() -> void:
	name = "attack1"
	if b:
		current_attack_count = b.default_attack_count1
	
func enter():
	current_attack_count = b.default_attack_count1
	b.attack1Delay.start()
	signal_emitted = false
	
	if randi()%2 == 1:
		b.attack_rotation1 *= -1

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
			b.emit_signal("attack_end")
			signal_emitted = true
			b.attack1Delay.stop()
		return
		
	c.spawn_circle_of_projectiles(
		b.projectile_count1,
		b.projectile_spawn_distance1,
		Vector2(0, 0),
		b.attack_rotation1 * (b.default_attack_count1 - current_attack_count)
	)
	current_attack_count -= 1
	b.attack1Delay.start()
