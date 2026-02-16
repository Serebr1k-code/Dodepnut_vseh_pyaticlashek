class_name State extends Node

@export var state_machine: StateMachine

func enter(): # вызывается при входе в это состояние
	pass

func exit(): # вызывается при выходе из этого состояния
	pass

# все update функции это просто process но они нужны так как они разные у разных состояний

func update_input(event: InputEvent): 
	pass

func update(delta: float):
	pass

func update_physics(delta: float):
	pass
