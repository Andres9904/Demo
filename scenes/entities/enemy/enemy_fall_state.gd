extends StateMachStateComponent

@export var _move_state:StateMachStateComponent

var enemy:Enemy
var _can_move = false

func enter(previous_state:StateMachStateComponent) -> void:
	enemy = state_machine.subject
	_can_move = false
	var tween := get_tree().create_tween()
	tween.tween_callback(_stop_fall)
	tween.tween_property(enemy, "position", Vector2(enemy.position.x, enemy.position.y + 40), .25).set_trans(Tween.TRANS_LINEAR)

func exit() -> void:
	pass

func run_process(delta: float) -> StateMachStateComponent:
	if _can_move:
		return _move_state
	return null

func run_physics_process(delta: float) -> StateMachStateComponent:
	return null

func run_input(event: InputEvent) -> StateMachStateComponent:
	return null

func _stop_fall() -> void:
	_can_move = true
