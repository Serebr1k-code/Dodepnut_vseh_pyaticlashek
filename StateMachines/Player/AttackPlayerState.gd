class_name MeleeAttackPlayerState extends PlayerState

var need_connect = true

func _ready() -> void:
	name = "melee_attack"

func enter():
	if need_connect:
		p.slash.w0.body_entered.connect(on_slash_body_entered)
		p.slash.w1.body_entered.connect(on_slash_body_entered)
		p.slash.w2.body_entered.connect(on_slash_body_entered)
		need_connect = false
	#if p.hud: p.hud.change_current_state(name)
	p.hitbox_delay.wait_time = 0.1/p.fx.speed_scale
	p.attacking = true
	p.canCast = false
	var delay := 0.0
	if p.current_weapon == 0:
		delay = p.weapon1_settings[p.next_attack].delay
	elif p.current_weapon == 1:
		delay = p.weapon2_settings[p.next_attack].delay
	elif p.current_weapon == 2:
		delay = p.weapon3_settings[p.next_attack].delay
	if delay <= 0.01:
		enter_fr()
	else:
		p.swing_delay.start()

func exit():
	p.sprite.speed_scale = 1.0
	p.attacking = false

func update_input(event: InputEvent):
	pass

func update(delta: float):
	if p.velocity.x:
		if p.move_dir and p.move_dir != p.last_dir:
			p.sprite.speed_scale = -1.0
		else:
			p.sprite.speed_scale = 1.0
		p.sprite.play("run")
	else:
		p.sprite.play("idle")
	if p.fx.animation.contains("slash") and p.hitbox_delay.is_stopped():
		p.slash.attack(p.next_attack, p.current_weapon)
	else:
		p.slash.disable_all()
	
	if Input.is_action_just_pressed("Attack") and not p.combo.is_stopped():
		p.combo.stop()
		p.combo_counter += 1
		state_machine.reenter_state()
	
	c.handle_input()

func update_physics(delta: float):
	c.handle_physics(delta)
	c.handle_movement()
	c.handle_jump()

func on_slash_body_entered(body: Node2D) -> void:
	if body.is_in_group("HaveHealth") and not body is Player:
		body.take_damage.emit(p.current_damage, p.current_damage_type)
	if body is Projectile:
		body.queue_free()

func _on_combo_timeout() -> void:
	p.next_attack = 0
	p.combo_counter = 0
	state_machine.change_state("idle")


func _on_attack_timer_timeout() -> void:
	p.sword.play("idle")
	p.fx.play("idle")
	p.next_attack += 1
	if p.current_weapon == 0:
		p.next_attack = p.next_attack % p.slash.weapon1.size()
	elif p.current_weapon == 1:
		p.next_attack = p.next_attack % p.slash.weapon2.size()
	elif p.current_weapon == 2:
		p.next_attack = p.next_attack % p.slash.weapon3.size()
	p.combo.start()


func _on_swing_delay_timeout() -> void:
	enter_fr()

func enter_fr():
	var target_anim := str(p.current_weapon) + "slash" + str(p.next_attack)
	p.sword.play(target_anim)
	p.fx.play(target_anim)
	
	if p.current_weapon == 0:
		p.fx.speed_scale = p.weapon1_settings[p.next_attack].speed_scale
		p.sword.speed_scale = p.weapon1_settings[p.next_attack].speed_scale
		p.current_damage = p.weapon1_settings[p.next_attack].damage
		p.current_damage_type = p.weapon1_settings[p.next_attack].damage_type
	elif p.current_weapon == 1:
		p.fx.speed_scale = p.weapon2_settings[p.next_attack].speed_scale
		p.sword.speed_scale = p.weapon2_settings[p.next_attack].speed_scale
		p.current_damage = p.weapon2_settings[p.next_attack].damage
		p.current_damage_type = p.weapon2_settings[p.next_attack].damage_type
	elif p.current_weapon == 2:
		p.fx.speed_scale = p.weapon3_settings[p.next_attack].speed_scale
		p.sword.speed_scale = p.weapon3_settings[p.next_attack].speed_scale
		p.current_damage = p.weapon3_settings[p.next_attack].damage
		p.current_damage_type = p.weapon3_settings[p.next_attack].damage_type
		
	p.attack_timer.wait_time = p.fx.sprite_frames.get_frame_count(target_anim) \
	/ p.fx.sprite_frames.get_animation_speed(target_anim) \
	/ p.fx.speed_scale
	p.attack_timer.start()
	p.hitbox_delay.start()
