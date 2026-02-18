class_name BossStateMachine extends StateMachine

@export var b : Boss
@export var c : BossController

func _input(event: InputEvent) -> void:
	current_state.update_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)

func _on_boss_attack_end() -> void:
	change_state("idle")
	b.betweenAttackTime.start()

const ATTACK_COUNT = 3

func randomly_choose_attack() -> void:
	var attack := randi_range(0, 2)
	if attack == 0:
		change_state("attack1")
	elif attack == 1:
		change_state("attack2")
	elif attack == 2:
		change_state("attack3")

func _on_between_attack_time_timeout() -> void:
	randomly_choose_attack()
	b.betweenAttackTime.stop()
