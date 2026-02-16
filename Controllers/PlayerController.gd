class_name PlayerController extends Node

@export var p: Player
@export var m: PlayerStateMachine

func _process(delta: float) -> void:
	# Quit game if player dies
	if p.Health <= 0:
		get_tree().quit()
	
	# Updating base variables
	p.falling = p.velocity.y > 0
	if p.jumping and p.falling:
		p.jumping = false
	elif Input.is_action_just_pressed("Jump") and p.velocity.y <= 0:
		p.jumping = true
	if p.is_on_floor() and not (p.canDash and not p.attacking):
		p.canDash = true
	

func _physics_process(delta: float) -> void:

	p.move_and_slide()

func handle_physics(delta: float):
	# Add the gravity
	p.velocity += p.G * delta
	
	# Controlable jump height
	if p.jumping and Input.is_action_just_released("Jump"):
		p.velocity.y = 0
		p.move_and_slide()

func handle_input():
	# Get move input
	p.raw_dir = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	p.move_dir = p.raw_dir.x
	if p.raw_dir.x and !p.dashing:
		p.last_dir = p.raw_dir.x
	
	# Get dash input
	if Input.is_action_just_pressed("Dash") and p.canDash and not p.dashing and p.dash_delay.is_stopped() and not p.attacking:
		#p.dash_particles.emitting = true
		p.dashing = true
		p.canDash = false
		p.dash_length.start()
	
	# Get cast spell input
	if Input.is_action_just_pressed("Spell") and p.canCast and not p.casting:
		m.change_state("cast")

func handle_movement():
	# Move player left and right
	if not p.dashing:
		p.sprite.flip_h = p.last_dir == -1
		p.spell_pos.position.x = 14.5*p.last_dir
		if p.move_dir:
			p.velocity.x = move_toward(p.velocity.x, p.move_dir * p.SPEED, p.SPEED)
		else:
			p.velocity.x = move_toward(p.velocity.x, 0, p.SPEED)
	# Move player while dash
	else:
		p.sprite.flip_h = p.last_dir == -1
		p.spell_pos.position.x = 14.5*p.last_dir
		p.velocity.x = p.last_dir * p.SPEED * 3
		p.velocity.y = 0.0

func handle_jump():
	# Handle jump
	if Input.is_action_just_pressed("Jump"):
		p.velocity.y = p.JUMP_VELOCITY

func _on_dash_length_timeout() -> void:
	p.dashing = false
	p.dash_delay.start()

func _on_inv_frames_timeout() -> void:
	p.is_invincible = false


func _on_player_take_damage(recieved_damage: int) -> void:
	pass # ВЫ РАЗДОЛБАИ ПИШИТЕ КОД
	p.is_invincible = true
	p.inv_frames.start()


func _on_dash_delay_timeout() -> void:
	pass # Replace with function body.


func _on_magic_animation_timeout() -> void:
	var proj : Dictionary [int, Projectile] = {}
	for i in range(0, 1):
		proj[i] = p.projectile_scene.instantiate()
		proj[i].position = p.spell_pos.global_position
		proj[i].velocity = Vector2((600+randi_range(0, 100)) * p.last_dir, randi_range(-200, 200))
	for i in range(0, 1):
		p.get_parent().add_child(proj[i])
	m.change_state("idle")
