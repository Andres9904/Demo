extends StateMachStateComponent

@export var _fall_state:StateMachStateComponent
@onready var _laser_cannon := $"../../LaserCannon"
@onready var _shoot_delay := $"../../ShootDelay"

var enemy:Enemy
var fall:bool

func enter() -> void:
	enemy = state_machine.target
	fall = false
	_shoot_delay.start()
	var rand = RandomNumberGenerator.new()
	_laser_cannon.cooldown = rand.randf_range(.8, 1.6)

func exit() -> void:
	pass

func run_process(delta: float) -> StateMachStateComponent:
	_shoot()
	enemy.position += enemy.velocity * delta
	if fall:
		return _fall_state
	return null

func run_physics_process(delta: float) -> StateMachStateComponent:
	return null

func run_input(event: InputEvent) -> StateMachStateComponent:
	return null

func _shoot() -> void:
	if !_can_shoot():
		return
	var laser_direction = Vector2(0, 1)
	_laser_cannon.fire_laser(laser_direction)

func _can_shoot() -> bool:
	return _laser_cannon.can_fire() && _shoot_delay.is_stopped()

func _on_border_hit(body: Node2D) -> void:
	enemy.velocity.x *= -1
	fall = true
