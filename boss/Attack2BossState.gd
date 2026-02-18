class_name Attack2BossState extends State

@export var b: Boss
@export var c: BossController

var current_attack_count
var current_hole_position
var signal_emitted = false

func _ready() -> void:
	name = "attack2"
	if b:
		current_attack_count = b.default_attack_count2
		current_hole_position = randi() % int(180 - b.hole_size2)
	
func enter():
	current_attack_count = b.default_attack_count2
	current_hole_position = randi() % int(180 - b.hole_size2)
	signal_emitted = false
	b.attack2Delay.start()
	
	if randi() % 2 == 1:
		b.attack_rotation2 *= -1

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
			b.emit_signal("attack_end")
			signal_emitted = true
			b.attack2Delay.stop()
		return
	
	c.spawn_circle_of_projectiles_with_hole(
		b.projectile_count2, b.projectile_speed2,
		b.projectile_spawn_distance2,
		Vector2(0, 0),
		b.attack_rotation2 * (b.default_attack_count2 - current_attack_count),
		current_hole_position,
		current_hole_position + b.hole_size2
	)
	
	var hole_step := randi() % int((b.max_hole_step2 / 2) + (b.max_hole_step2 / 2))
	hole_step *= 1 if (randi() % 2 == 1) else -1
	if current_hole_position + hole_step < 0:
		current_hole_position -= hole_step
	elif current_hole_position + hole_step > 180 - b.hole_size2:
		current_hole_position -= hole_step
	else:
		current_hole_position += hole_step
	
	current_attack_count -= 1
	b.attack2Delay.start()
