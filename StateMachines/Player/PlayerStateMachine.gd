class_name PlayerStateMachine extends StateMachine

@export var p: Player

func _input(event: InputEvent) -> void:
	current_state.update_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)
	
	if !p.is_on_floor():
		change_state("airborne")
	elif Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		change_state("move")
	else:
		change_state("idle")

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)
