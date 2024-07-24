class_name Enemy extends Node2D

@export var velocity := Vector2()
@export var _can_move := true

@onready var _laser_cannon := $LaserCannon
@onready var _shoot_delay := $ShootDelay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_shoot()
	_move(delta)
	
func _die() -> void:
	queue_free()

func _on_health_hit_zero() -> void:
	_die()

func _on_hit_border(body: Node2D) -> void:
	velocity.x *= -1
	_fall()

func _shoot() -> void:
	if !_can_shoot():
		return
	var laser_direction = Vector2(0, 1)
	_laser_cannon.fire_laser(laser_direction)

func _can_shoot() -> bool:
	return _laser_cannon.can_fire() && _shoot_delay.is_stopped()

func _move(delta:float) -> void:
	if _can_move:
		position += velocity * delta

func _fall() -> void:
	var tween := get_tree().create_tween()
	tween.tween_callback(_stop_fall)
	tween.tween_property(self, "position", Vector2(position.x, position.y + 40), .25).set_trans(Tween.TRANS_LINEAR)
	_can_move = false
	
func _stop_fall() -> void:
	_can_move = true

func _on_health_became_zero_event() -> void:
	Global.score += 1
	queue_free()
