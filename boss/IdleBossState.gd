class_name IdleBossState extends State

@export var b: Boss
@export var c: BossController

func _ready() -> void:
	name = "idle"

func enter():
	pass

func exit():
	pass

func update_input(event: InputEvent):
	pass

func update(delta: float):
	pass
	#b.betweenAttackTime.start()

func update_physics(delta: float):
	pass
