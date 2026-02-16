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
	var speed = e.SPEED
	if m.current_state.name == "dash":
		speed *= e.dash_speed_mult
	safe_velocity.x = min(speed, max(-speed, safe_velocity.x))
	safe_velocity.y = min(speed, max(-speed, safe_velocity.y))
	e.velocity = e.velocity.move_toward(safe_velocity, acel)

func go_to(pos: Vector2):
	e.nav_agent.target_position = pos

func create_proj(ang: float):
	var proj: Projectile
	for i in range(0, e.proj_count):
		proj = e.projectile_scene.instantiate()
		proj.position = e.global_position
		proj.velocity = Vector2.from_angle(ang + e.proj_start_ang + e.proj_ang*i)*e.proj_speed
		proj.damage = e.proj_damage
		e.get_parent().add_child(proj)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		area.get_parent().take_damage.emit(e.contact_damage)
