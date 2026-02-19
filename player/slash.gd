class_name Slash extends Node2D

@onready var w0: Area2D = $"0"
@onready var w1: Area2D = $"1"
@onready var w2: Area2D = $"2"

var weapon1: Array[CollisionPolygon2D]
var weapon2: Array[CollisionPolygon2D]
var weapon3: Array[CollisionPolygon2D]

func _ready() -> void:
	for weapon in get_children():
		for child in weapon.get_children():
			if weapon.name == "0":
				weapon1.append(child)
			elif weapon.name == "1":
				weapon2.append(child)
			elif weapon.name == "2":
				weapon3.append(child)

func attack(num: int, weapon_id: int):
	if weapon_id == 0:
		weapon1[num].set_deferred("disabled", false)
	elif weapon_id == 1:
		weapon2[num].set_deferred("disabled", false)
	elif weapon_id == 2:
		weapon3[num].set_deferred("disabled", false)
	
func disable_all():
	for weapon in get_children():
		for child in weapon.get_children():
			child.set_deferred("disabled", true)
