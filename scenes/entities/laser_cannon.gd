extends Node2D

@export var cooldown:float = 1
@export var laser_scene:PackedScene
@export var laser_stats:LaserStats
@export var spawn_point:Marker2D

@onready var _cooldown_timer := $CooldownTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func fire_laser(direction:Vector2):
	var laser := laser_scene.instantiate() as Laser
	laser.laser_stats = laser_stats
	laser.direction = direction
	laser.global_position = spawn_point.global_position if spawn_point != null else global_position
	get_tree().current_scene.add_child(laser)
	_cooldown_timer.wait_time = cooldown
	_cooldown_timer.start()

func can_fire() -> bool:
	return _cooldown_timer.is_stopped()
