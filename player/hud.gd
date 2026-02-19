class_name Hud extends CanvasLayer

@onready var hps : Dictionary [int, AnimatedSprite2D] = {
	1: $"1",
	2: $"2",
	3: $"3",
	4: $"4",
	5: $"5"
}

func _ready() -> void:
	update_health(5)

func update_health(new_hp: int):
	for i in range(1, 5+1):
		if i<=new_hp:
			hps[i].play("Full")
		else:
			hps[i].play("Empty")

func update_fly(fly_time: float):
	$Fly.value = fly_time

func update_soul(new_soul: float):
	$Soul.value = new_soul

func update_weapon(weapon_id: int):
	$WeaponHud.play(str(weapon_id))
