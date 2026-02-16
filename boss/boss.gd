class_name Boss extends CharacterBody2D

signal attack_end()

@onready var bossProjectile = preload("res://boss/boss_projectile.tscn")
@onready var bossSpike = preload("res://boss/boss_spike.tscn")

@onready var collisionShape : CollisionShape2D = $CollisionShape2D
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var betweenAttackTime : Timer = $Timers/BetweenAttackTime
@onready var attack1Delay : Timer = $Timers/Attack1Delay
@onready var attack2Delay : Timer = $Timers/Attack2Delay
@onready var attack3Delay : Timer = $Timers/Attack3Delay

@export_category("Stats")
@export var Health := 1600
@export var maxHealth := 1600
@export var Damage := 1

func _ready() -> void:
	animatedSprite.z_index = 10
