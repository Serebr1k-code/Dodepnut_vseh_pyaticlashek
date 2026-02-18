class_name Player extends CharacterBody2D

signal take_damage(recieved_damage : int)

# Preload scenes
#@onready var slash_scene = preload("res://Player/slash.tscn")
#@onready var arrow_scene = preload("res://Player/arrow.tscn")
#@onready var nuke_scene = preload("res://Player/nuke.tscn")
@onready var projectile_scene = preload("res://player/projectile.tscn")

# Links to childs
@onready var camera : Camera2D = $Camera2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $Sprite
@onready var sword : AnimatedSprite2D = $Sword
@onready var fx : AnimatedSprite2D = $FX
@onready var inv_frames : Timer = $Timers/InvFrames
@onready var dash_length : Timer = $Timers/DashLength
@onready var dash_delay : Timer = $Timers/DashDelay
@onready var magic_anim : Timer = $Timers/MagicAnimation
@onready var spell_pos : Marker2D = $SpellPos
@onready var slash: Slash = $Slash
@onready var hud: Hud = $"../Hud"
@onready var hitbox_collision: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var hitbox: Area2D = $Hitbox
@onready var dash_reload: CPUParticles2D = $Particles/DashReload
@onready var left_fly_particles : CPUParticles2D = $Particles/Left
@onready var right_fly_particles : CPUParticles2D = $Particles/Right
@onready var shade_dash_delay: Timer = $Timers/ShadeDashDelay
@onready var attack_timer: Timer =  $Timers/AttackTimer
@onready var combo: Timer = $Timers/Combo
@onready var swing_delay: Timer = $Timers/SwingDelay

# consts
const G := Vector2(0, 980)

@export_category("Stats")
@export var SPEED := 350.0
@export var JUMP_VELOCITY := -500.0
@export var WINGS_VELOCITY := -500.0
@export var Health := 5
@export var maxHealth := 5
@export var max_fly_time := 3.0
@export_category("Abilities")
@export var have_dash := false
@export_category("Projectiles")
@export var proj_ang := deg_to_rad(10)
@export var proj_speed := 600
@export var proj_count := 2
@export var proj_damage := 5
@export var cast_speed := 1.0
@export_category("Attacks")
@export var attack_settings: Array[AttackSettings]

# canSmth vars
var canAttack := true
var canDash := true
var canCast := true
var can_shade_dash := true

# doing smth vars
var jumping := false
var falling := false
var dashing := false
var attacking := false
var casting := false

# is fucking invincible vars
var is_invincible := false

# gameplay vars
var raw_dir := Vector2.ZERO
var move_dir := 0.0
var last_dir := 1.0
var next_attack := 0
var combo_counter := 0.0
var fly_time := max_fly_time
var target
var current_damage := 5
var current_damage_type : Damage.Type = Damage.Type.Physical

func _ready() -> void:
	magic_anim.wait_time = 2.6/cast_speed
