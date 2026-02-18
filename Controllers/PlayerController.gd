class_name PlayerController extends Node

@export var p: Player
@export var m: PlayerStateMachine

func _process(delta: float) -> void:
	# Поворот игрока и всех хитбоксов
	p.sprite.flip_h = p.last_dir == -1 
	p.sword.flip_h = p.last_dir == -1 
	p.fx.flip_h = p.last_dir == -1 
	p.spell_pos.position.x = 14.5*p.last_dir
	if p.last_dir == -1:
		p.slash.scale = Vector2(-1, 1)
	else:
		p.slash.scale = Vector2(1, 1)
	var combo_boost:float = 1.0 + p.combo_counter/10
	p.slash.scale *= combo_boost
	if p.attacking:
		p.fx.position = Vector2(0.5, -5.5) * combo_boost
		p.fx.scale = Vector2.ONE * combo_boost
	else:
		p.fx.position = Vector2(0.5, -5.5)
		p.fx.scale = Vector2.ONE
	
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
	if p.is_on_floor():
		p.fly_time = p.max_fly_time
		p.hud.update_fly(p.fly_time)
	

func _physics_process(delta: float) -> void:

	p.move_and_slide()

func handle_physics(delta: float) -> void:
	# Add the gravity
	p.velocity += p.G * delta
	
	# Controlable jump height
	if p.jumping and Input.is_action_just_released("Jump"):
		p.velocity.y = 0
		p.move_and_slide()

func handle_input() -> void:
	# Get move input
	p.raw_dir = Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	p.move_dir = p.raw_dir.x
	if p.raw_dir.x and not p.dashing and not p.attacking:
		p.last_dir = p.raw_dir.x
	
	# Get dash input
	if Input.is_action_just_pressed("Dash") and p.canDash and not p.dashing and p.dash_delay.is_stopped() and not p.attacking:
		#p.dash_particles.emitting = true
		p.dashing = true
		p.canDash = false
		p.dash_length.start()
		if p.can_shade_dash:
			p.can_shade_dash = false
			p.shade_dash_delay.start()
			p.is_invincible = true
			p.hitbox_collision.set_deferred("disabled", true)
			p.sprite.modulate = Color(0.2, 0.2, 0.2, 1)
	
	# Get cast spell input
	if Input.is_action_just_pressed("Spell") and p.canCast and not p.casting:
		m.change_state("cast")

func handle_movement() -> void:
	# Move player left and right
	if not p.dashing:
		if p.move_dir:
			p.velocity.x = move_toward(p.velocity.x, p.move_dir * p.SPEED, p.SPEED)
		else:
			p.velocity.x = move_toward(p.velocity.x, 0, p.SPEED)
	# Move player while dash
	else:
		p.velocity.x = p.last_dir * p.SPEED * 3
		p.velocity.y = 0.0

func handle_jump() -> void:
	# Handle jump
	if p.is_on_floor() and Input.is_action_just_pressed("Jump"):
		p.velocity.y = p.JUMP_VELOCITY

func _on_dash_length_timeout() -> void:
	p.dashing = false
	p.dash_delay.start()
	if p.is_invincible and p.inv_frames.is_stopped(): # если шейд деш то неуязв
		p.is_invincible = false
		p.hitbox_collision.set_deferred("disabled", false)
		p.sprite.modulate = Color(1, 1, 1, 1.0)

# выход из неуязва
func _on_inv_frames_timeout() -> void:
	p.is_invincible = false
	p.hitbox_collision.set_deferred("disabled", false)
	p.sprite.modulate = Color(1, 1, 1, 1.0)

# Урон
func _on_player_take_damage(recieved_damage: int) -> void:
	if not p.is_invincible:
		p.Health -= recieved_damage
		if p.Health <= 0:
			get_tree().quit()
		p.hud.update_health(p.Health)
		p.is_invincible = true
		p.inv_frames.start()
		p.hitbox_collision.set_deferred("disabled", true)
		p.sprite.modulate = Color(2, 2, 2, 1)

# Хз зачем это здесь
func _on_dash_delay_timeout() -> void:
	pass

# там короче чтобы анимация магии была, есть таймер, и вот в его конце я спавню проджектайлы
func _on_magic_animation_timeout() -> void:
	var proj : Dictionary [int, Projectile] = {}
	for i in range(0, 1):
		proj[i] = p.projectile_scene.instantiate()
		proj[i].position = p.spell_pos.global_position
		proj[i].velocity = Vector2((600+randi_range(0, 100)) * p.last_dir, randi_range(-200, 200))
	for i in range(0, 1):
		p.get_parent().add_child(proj[i])
	m.change_state("idle")

func handle_melee_attacks() -> void:
	if Input.is_action_just_pressed("Attack") and p.canAttack and not p.attacking:
		m.change_state("melee_attack")

# перезарядка шейд деша
func _on_shade_dash_delay_timeout() -> void:
	p.dash_reload.emitting = true
	p.can_shade_dash = true
