class_name StateMachine extends Node

@export var init_state: State
var current_state: State


var states: Dictionary [String, State] = {
	
}

# добавляем всех детей в стейты
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	
	if init_state:
		current_state = init_state
		init_state.enter()
# 3 функции ниже как раз чтобы обновлять update
func _input(event: InputEvent) -> void:
	current_state.update_input(event)

func _process(delta: float) -> void:
	current_state.update(delta)

func _physics_process(delta: float) -> void:
	current_state.update_physics(delta)

func change_state(new_state_name: String):
	if current_state.name.to_lower() == new_state_name.to_lower():
		return
	
	if current_state:
		current_state.exit()
	
	current_state = states[new_state_name.to_lower()]
	
	current_state.enter()

# по факту это не надо но мне пока что лень переделывать
func reenter_state():
	current_state.exit()
	current_state.enter()
