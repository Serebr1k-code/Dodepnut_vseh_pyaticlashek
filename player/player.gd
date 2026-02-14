class_name Player extends CharacterBody2D

signal take_damage(recieved_damage : int)

# Preload scenes
#@onready var slash_scene = preload("res://Player/slash.tscn")
#@onready var arrow_scene = preload("res://Player/arrow.tscn")
#@onready var nuke_scene = preload("res://Player/nuke.tscn")

# Links to childs
@onready var camera : Camera2D = $Camera2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var inv_frames : Timer = $Timers/InvFrames
@onready var dash_length : Timer = $Timers/DashLength
@onready var dash_delay : Timer = $Timers/DashDelay

# consts
const G := Vector2(0, 980)

@export_category("Stats")
@export var SPEED := 250.0
@export var JUMP_VELOCITY := -600.0
@export var Health := 5
@export var maxHealth := 5
@export var Damage := 5
@export_category("Abilities")
@export var have_dash := false

# canSmth vars
var canAttack := true
var canDash := true

# doing smth vars
var jumping := false
var falling := false
var dashing := false
var attacking := false

# is fucking invincible vars
var is_invincible := false

# gameplay vars
var raw_dir := Vector2.ZERO
var move_dir := 0.0
var last_dir := 1.0
