class_name PlayerStateMachine extends StateMachine

@export var p: Player

func _input(event: InputEvent) -> void:
	current_state.update_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)
	# определяем состряния
	if p.attacking:
		change_state("melee_attack")
	elif current_state.name == "cast" or (current_state.name == "fly" and not p.is_on_floor()):
		pass
	elif !p.is_on_floor():
		change_state("airborne")
	elif p.velocity.x:
		change_state("move")
	else:
		change_state("idle")

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)
