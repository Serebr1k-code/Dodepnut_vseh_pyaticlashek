class_name FlyingEnemyController extends Node

@export var e: FlyingEnemy
@export var m: FlyingEnemyStateMachine

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var next_path_pos = e.nav_agent.get_next_path_position()
	var direction = e.global_position.direction_to(next_path_pos)
	var new_velocity = direction * e.SPEED
	if m.current_state.name == "dash":
		new_velocity *= e.dash_speed_mult
	#print(next_path_pos, direction, new_velocity)
	
	e.nav_agent.velocity = new_velocity
	e.move_and_slide()

func _on_nav_velocity_computed(safe_velocity: Vector2) -> void:
	var acel = 100
	if m.current_state.name == "dash":
		acel *= e.dash_speed_mult
	e.velocity = e.velocity.move_toward(safe_velocity, acel)

func go_to(pos: Vector2):
	e.nav_agent.target_position = pos

func create_proj(ang: float):
	var proj
	for i in range(0, e.proj_count):
		proj = e.projectile_scene.instantiate()
		proj.position = e.global_position
		proj.velocity = Vector2.from_angle(ang + e.proj_start_ang + e.proj_ang*i)*e.proj_speed
		e.get_parent().add_child(proj)
