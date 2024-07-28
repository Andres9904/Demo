class_name StateMachComponent extends Node

@export var target:Node
@export var _initial_state: StateMachStateComponent
@export var _auto_start:bool

var _current_state: StateMachStateComponent
var _playing:bool

signal state_machine_started_event(state:StateMachStateComponent)
signal state_machine_stopped_event()
signal state_changed_event(old_value:StateMachStateComponent, new_value:StateMachStateComponent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if _auto_start:
		start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_state = _current_state.run_process(delta)
	if new_state:
		_change_state(new_state)
	
func _physics_process(delta: float) -> void:
	var new_state = _current_state.run_physics_process(delta)
	if new_state:
		_change_state(new_state)
		
func _unhandled_input(event: InputEvent) -> void:
	var new_state = _current_state.run_input(event)
	if new_state:
		_change_state(new_state)

func is_playing() -> bool:
	return _playing

## Initialize the state machine by giving each child state a reference to the
## parent object it belongs to and enter the default starting_state.
func start() -> void:
	if is_playing():
		return
	
	_playing = true
	
	for state in get_children():
		if state is StateMachStateComponent:
			state.state_machine = self

	_change_state(_initial_state)
	state_machine_started_event.emit(_current_state)

func stop() -> void:
	if !is_playing():
		return
	
	_playing = false

	_change_state(_initial_state)
	state_machine_stopped_event.emit()

func _change_state(new_state:StateMachStateComponent) -> void:
	if _current_state == new_state:
		return
	if _current_state:
		_current_state.exit()

	_current_state = new_state
	_current_state.enter()
