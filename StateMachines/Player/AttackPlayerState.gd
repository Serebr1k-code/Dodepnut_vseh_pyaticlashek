class_name MeleeAttackPlayerState extends PlayerState

func _ready() -> void:
	name = "melee_attack"

func enter():
	#if p.hud: p.hud.change_current_state(name)
	p.attacking = true
	p.canCast = false
	if p.attack_settings[p.next_attack].delay <= 0.01:
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
	if p.fx.animation.contains("slash") and p.fx.frame == 1:
		p.slash.attack(p.next_attack)
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


func _on_slash_body_entered(body: Node2D) -> void:
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
	p.next_attack = p.next_attack % p.slash.slashes.size()
	p.combo.start()


func _on_swing_delay_timeout() -> void:
	enter_fr()

func enter_fr():
	var target_anim := "slash" + str(p.next_attack)
	p.sword.play(target_anim)
	p.fx.play(target_anim)
	p.fx.speed_scale = p.attack_settings[p.next_attack].speed_scale
	p.sword.speed_scale = p.attack_settings[p.next_attack].speed_scale
	p.current_damage = p.attack_settings[p.next_attack].damage
	p.attack_timer.wait_time = p.fx.sprite_frames.get_frame_count(target_anim) \
	/ p.fx.sprite_frames.get_animation_speed(target_anim) \
	/ p.fx.speed_scale
	p.current_damage_type = p.attack_settings[p.next_attack].damage_type
	p.attack_timer.start()
