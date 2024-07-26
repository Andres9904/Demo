class_name Laser extends Node2D

@export var laser_stats:LaserStats
@export var direction := Vector2()
var _speed := 500

@onready var _color_rect := $ColorRect
@onready var _damagebox := $DamageboxComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_apply_stats()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * _speed * delta
	var screen_height:int = get_viewport().size[1]
	if position.y + 40 < 0 || position.y - 40 > screen_height:
		_destroy()

func _apply_stats() -> void:
	if laser_stats == null:
		return
	_color_rect.color = laser_stats.color
	_damagebox.damage = laser_stats.damage
	_damagebox.collision_layer = laser_stats.collision_layer
	_damagebox.collision_mask = laser_stats.collision_mask
	_speed = laser_stats.speed

func _on_deal_damage_event(damage: int, hitbox: Hitbox2DComponent) -> void:
	_destroy()

func _destroy() -> void:
	queue_free()
