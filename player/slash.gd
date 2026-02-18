class_name Slash extends Area2D

var slashes: Array[CollisionPolygon2D]

func _ready() -> void:
	for child in get_children():
		slashes.append(child)

func attack(num: int):
	slashes[num].set_deferred("disabled", false)
	
func disable_all():
	for child in get_children():
		child.set_deferred("disabled", true)
