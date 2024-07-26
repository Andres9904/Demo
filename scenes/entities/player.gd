class_name Player extends CharacterBody2D

@export var speed := 500
@onready var _laser_cannon := $LaserCannon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_shoot()
	
func _physics_process(delta: float) -> void:
	_move()

func _move() -> void:
	var new_velocity := Vector2()
	if Input.is_action_pressed("move_left"):
		new_velocity.x = -speed
	if Input.is_action_pressed("move_right"):
		new_velocity.x = speed
	velocity = new_velocity
	move_and_slide()
	
func _shoot() -> void:
	if !Input.is_action_just_pressed("fire_laser") && !(Input.is_action_pressed("fire_laser") && _laser_cannon.can_fire()): 
		return
	var laser_direction = Vector2(0, - 1)
	_laser_cannon.fire_laser(laser_direction)
