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
