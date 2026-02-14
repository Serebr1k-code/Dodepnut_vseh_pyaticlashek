extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Количество прыжков
const MAX_JUMPS = 2
var jump_count = 0

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		# Сбрасываем счетчик прыжков при падении (если не в воздухе)
		if jump_count == 0:
			jump_count = 1
	else:
		# На земле сбрасываем счетчик прыжков
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Прыжок с земли
			velocity.y = JUMP_VELOCITY
			jump_count = 1
			animated_sprite.play("jump")
		elif jump_count < MAX_JUMPS:
			# Двойной прыжок в воздухе
			velocity.y = JUMP_VELOCITY
			jump_count += 1
			animated_sprite.play("air_jump")

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		# Поворачиваем спрайт в зависимости от направления
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Обновляем анимацию после движения
	update_animation()

func update_animation():
	# Определяем текущее состояние для анимации
	
	if is_on_floor():
		# На земле
		if velocity.x == 0:
			# Стоим на месте
			animated_sprite.play("idle")
		else:
			# Бежим
			animated_sprite.play("run")

## Функция для получения урона (пока без реализации, но анимация есть)
#func take_damage():
	#animated_sprite.play("hurt")
	## Здесь можно добавить логику получения урона
	#await animated_sprite.animation_finished
	## После анимации урона возвращаемся к обычной анимации
	#update_animation()
#
## Функция смерти
#func die():
	#animated_sprite.play("death")
	## Отключаем управление
	#set_physics_process(false)
	## Можно добавить таймер для перезагрузки сцены
	#await animated_sprite.animation_finished
	## Здесь логика смерти (например, перезагрузка сцены)
	## get_tree().reload_current_scene()
