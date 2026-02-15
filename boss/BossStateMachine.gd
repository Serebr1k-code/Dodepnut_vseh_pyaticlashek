class_name BossStateMachine extends StateMachine

@export var boss : Boss
@export var bossController : BossController

# func _ready() -> void:
	#change_state("idle")
	#print(boss)
	#boss.betweenAttackTime.start()
	
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

func randomly_choose_attack() -> void:
	var attack := randi() % 1 + 1
	if attack == 1:
		change_state("attack1")

func _on_between_attack_time_timeout() -> void:
	randomly_choose_attack()
