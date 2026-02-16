class_name BossStateMachine extends StateMachine

@export var boss : Boss
@export var bossController : BossController

var rng := RandomNumberGenerator.new()
var firstRun := true

func _input(event: InputEvent) -> void:
	current_state.update_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)
	
	if firstRun:
		boss.betweenAttackTime.start()
		firstRun = false

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)

func _on_boss_attack_end() -> void:
	change_state("idle")
	boss.betweenAttackTime.start()

const ATTACK_COUNT = 3

func randomly_choose_attack() -> void:
	var attack := rng.randi() % ATTACK_COUNT
	if attack == 0:
		change_state("attack1")
	elif attack == 1:
		change_state("attack2")
	elif attack == 2:
		change_state("attack3")

func _on_between_attack_time_timeout() -> void:
	randomly_choose_attack()
	boss.betweenAttackTime.stop()
