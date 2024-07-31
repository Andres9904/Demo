## Representation of a state machine. All StateMachStateComponent should be direct children of this node.
@tool
class_name StateMachComponent extends Node

## The node being controlled by the state machine.
@export var subject:Node:
	get: 
		return subject
	set(new_value):
		subject = new_value
		
		# Update node warning messages in editor
		if Engine.is_editor_hint():
			update_configuration_warnings()

## The initial starting state and default return state. Child state nodes can use to exit.
@export var idle_state: StateMachStateComponent:
	get:
		return idle_state
	set(new_value):
		var _requires_state_change = is_playing() && is_idle()
		idle_state = new_value
		
		if Engine.is_editor_hint():
			update_configuration_warnings()
			return
		else:
			if _requires_state_change:
				_change_state(new_value)

## If false, the state machine will not be running by default and you will have to call [method start] to run it.
@export var _auto_start:bool

var _current_state: StateMachStateComponent
var _playing:bool

## A signal fired whenever the state machine is started.
signal state_machine_started_event(state:StateMachStateComponent)
## A signal fired whenever the state machine is stopped.
signal state_machine_stopped_event()
## A signal fired whenever the state machine switchs to a new state.
signal state_changed_event(old_value:StateMachStateComponent, new_value:StateMachStateComponent)

func _ready() -> void:
	# We're a tool script, so don't run any extra code
	if Engine.is_editor_hint():
		return
		
	if _auto_start:
		start()

func _process(delta: float) -> void:
	# We're a tool script, so don't run any extra code
	if Engine.is_editor_hint():
		return
	
	# Process current state and switch states if needed
	var new_state = _current_state.run_process(delta)
	if new_state:
		_change_state(new_state)
	
func _physics_process(delta: float) -> void:
	# We're a tool script, so don't run any extra code
	if Engine.is_editor_hint():
		return
	
	# Process current state and switch states if needed
	var new_state = _current_state.run_physics_process(delta)
	if new_state:
		_change_state(new_state)
		
func _unhandled_input(event: InputEvent) -> void:
	# We're a tool script, so don't run any extra code
	if Engine.is_editor_hint():
		return
	
	# Process current state and switch states if needed
	var new_state = _current_state.run_input(event)
	if new_state:
		_change_state(new_state)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings:Array[String] = []
	
	# Validate required export properties are set
	if subject == null:
		warnings.append("Subject is required")
	if idle_state == null:
		warnings.append("Initial State is required")
	
	# Validating we have child states associated with our state machine
	if StateMachComponent.get_state_mach_state_component(self) == null:
		warnings.append("Missing child StateMachStateComponents nodes")
	return warnings

#will fire whenever node is validated
func _validate_property(property: Dictionary) -> void:
	#This will be called automatically when adding/removing child nodes
	if !Engine.is_editor_hint():
		return
	update_configuration_warnings()


## Internal function for handling when states need to change
func _change_state(new_state:StateMachStateComponent) -> void:
	if _current_state == new_state:
		return
	
	# Exists prior state if we have one
	var previous_state = _current_state
	if _current_state:
		_current_state.exit()

	# starts new state
	_current_state = new_state
	if _current_state:
		_current_state.state_machine = self
		_current_state.enter(previous_state)		
		

## If state machine is running
func is_playing() -> bool:
	return _playing

## If state machine is running and in the idle (default) state
func is_idle() -> bool:
	return is_playing() && _current_state == idle_state

## Starts the state machine with it's iniial state if it's not already running.
func start() -> void:
	if is_playing():
		return
	
	# Set our initial state
	_playing = true
	_change_state(idle_state)
	state_machine_started_event.emit(_current_state)

## Stops the state machine from running if it is already running.
func stop() -> void:
	if !is_playing():
		return
	
	# Stop current state
	_change_state(null)
	_playing = false
	state_machine_stopped_event.emit()	

## Fidnds the first state machine component of a node
static func get_state_mach_state_component(parent:Node, recursive:bool = false) -> StateMachStateComponent:
	for node in parent.get_children(recursive):
		if node is StateMachStateComponent:
			return node
	return null
