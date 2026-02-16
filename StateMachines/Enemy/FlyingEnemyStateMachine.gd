class_name FlyingEnemyStateMachine extends StateMachine

@export var e: FlyingEnemy

func _process(delta: float) -> void:
	current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)

func _on_agro_range_body_entered(body: Node2D) -> void:
	if body is Player:
		e.rage_timer.stop()
		e.target = body
		if e.target and current_state.name == "idle":
			var rando = randf()
			if rando <= e.dash_frec:
				change_state("dash")
			else:
				change_state("liberal")

func _on_rage_timer_timeout() -> void:
	change_state("idle")
	e.target = 0

func _on_nav_navigation_finished() -> void:
	pass


func _on_agro_range_body_exited(body: Node2D) -> void:
	e.rage_timer.start()


func _on_attack_swap_timeout() -> void:
	if e.target:
			var rando = randf()
			if rando <= e.dash_frec:
				change_state("dash")
			else:
				change_state("liberal")
