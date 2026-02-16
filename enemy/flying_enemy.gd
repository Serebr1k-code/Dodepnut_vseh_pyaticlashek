class_name FlyingEnemy extends CharacterBody2D

signal take_damage(recieved_damage: int)

@onready var projectile_scene = preload("res://player/projectile.tscn")

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var nav_agent: NavigationAgent2D = $Nav
@onready var agro_range: Area2D = $AgroRange
@onready var agro_collision: CollisionShape2D = $AgroRange/CollisionShape2D
@onready var rage_timer: Timer = $RageTimer
@onready var attack_swap: Timer = $AttackSwap
@onready var liberal_delay: Timer = $LiberalDelay
@onready var dash_repeat_delay: Timer = $DashRepeatDelay
@onready var liberal_move_delay: Timer = $LiberalMoveDelay

@export_category("Stats")
@export var health := 15
@export var damage := 1
@export var SPEED := 200
@export var agro_radius := 500
@export var forgive_time := 1.0
@export_category("Attacks")
@export var dash_frec := 0.3
@export var attack_swap_delay := 5.0
@export_category("Liberal settings")
@export var proj_count := 3
@export var proj_speed := 300
@export var proj_ang := deg_to_rad(15)
@export var proj_delay := 0.7
@export var move_delay := 0.5
@export var height := 200
@export var height_rando := 50
@export var left_right_rando := 200
@export_category("Dash settings")
@export var dash_speed_mult := 3
@export var dash_delay := 0.5

var target
var proj_start_ang := proj_ang*(proj_count-1)/(-2.0)

func _ready() -> void:
	attack_swap.wait_time = attack_swap_delay
	liberal_delay.wait_time = proj_delay
	dash_repeat_delay.wait_time = dash_delay
	liberal_move_delay.wait_time = move_delay
	agro_collision.shape.radius = agro_radius
	rage_timer.wait_time = forgive_time
