class_name FlyingEnemy extends CharacterBody2D

signal take_damage(recieved_damage: int, damage_type: Damage.Type)

@onready var projectile_scene = preload("res://player/projectile.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $Nav
@onready var agro_range: Area2D = $AgroRange
@onready var agro_collision: CollisionShape2D = $AgroRange/CollisionShape2D
@onready var rage_timer: Timer = $Timers/RageTimer
@onready var attack_swap: Timer = $Timers/AttackSwap
@onready var liberal_delay: Timer = $Timers/LiberalDelay
@onready var dash_repeat_delay: Timer = $Timers/DashRepeatDelay
@onready var liberal_move_delay: Timer = $Timers/LiberalMoveDelay
@onready var hitbox: Area2D = $Hitbox
@onready var inv_frames: Timer = $Timers/InvFrames

@export_category("Stats")
@export var health := 15
@export var contact_damage := 1
@export var proj_damage := 1
@export var SPEED := 200
@export var agro_radius := 500
@export var forgive_time := 1.0
@export_category("Attacks")
@export var dash_frec := 0.3
@export var attack_swap_delay := 5.0
@export_category("Liberal settings")
@export var proj_count := 3
@export var proj_speed := 300
@export var proj_ang := deg_to_rad(30)
@export var proj_delay := 0.7
@export var move_delay := 0.5
@export var height := 200
@export var height_rando := 50
@export var left_right_rando := 200
@export_category("Dash settings")
@export var dash_speed_mult := 3
@export var dash_delay := 0.5

var damage_types: Array[Damage.Type] = [
	Damage.Type.Physical,
	Damage.Type.Fire,
	Damage.Type.Ice,
	Damage.Type.Poison,
	Damage.Type.Lightning
]
var skill_issue := damage_types[randi_range(0, 4)]

var target
var proj_start_ang := proj_ang*(proj_count-1)/(-2.0)
var is_invincible := false

func _ready() -> void: # задаем данные из конфига
	attack_swap.wait_time = attack_swap_delay
	liberal_delay.wait_time = proj_delay
	dash_repeat_delay.wait_time = dash_delay
	liberal_move_delay.wait_time = move_delay
	agro_collision.shape.radius = agro_radius
	rage_timer.wait_time = forgive_time
	
	if sprite: sprite.play("idle")
