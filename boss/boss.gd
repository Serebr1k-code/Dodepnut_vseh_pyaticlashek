class_name Boss extends CharacterBody2D

signal attack_end()
signal take_damage(recieved_damage: int)

@onready var bossProjectile = preload("res://boss/boss_projectile.tscn")
@onready var bossSpike = preload("res://boss/boss_spike.tscn")

@onready var collisionShape : CollisionShape2D = $CollisionShape2D
@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var betweenAttackTime : Timer = $Timers/BetweenAttackTime
@onready var attack1Delay : Timer = $Timers/Attack1Delay
@onready var attack2Delay : Timer = $Timers/Attack2Delay
@onready var attack3Delay : Timer = $Timers/Attack3Delay

@export_category("Stats")
@export var Health := 100
@export var maxHealth := 100
@export var Damage := 1
@export_category("Attack1")
@export var default_attack_count1 := 0
@export var projectile_count1 := 0
@export var projectile_spawn_distance1 := 0.0
@export var attack_rotation1 := 0.0
@export_category("Attack2")
@export var default_attack_count2 := 0
@export var projectile_count2 := 0
@export var projectile_spawn_distance2 := 0.0
@export var attack_rotation2 := 0.0
@export var hole_size2 := 0.0
@export var max_hole_step2 := 0.0
@export var projectile_speed2 :=  0.0
@export_category("Attack3")
@export var default_attack_count3 := 0
@export var spike_spawn_distance3 := 0.0
@export var spike_count3 := 0.0
