class_name BaseEnemy extends CharacterBody2D

signal take_damage(recieved_damage: int)

@export_category("Stats")
@export var health := 15
@export var damage := 1
