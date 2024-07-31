class_name StateMachStateComponent extends Node

var state_machine:StateMachComponent

func enter(previous_state:StateMachStateComponent) -> void:
	pass

func exit() -> void:
	pass

func run_process(delta: float) -> StateMachStateComponent:
	return null

func run_physics_process(delta: float) -> StateMachStateComponent:
	return null

func run_input(event: InputEvent) -> StateMachStateComponent:
	return null

static func get_state_mach_state_component(parent:Node, recursive:bool = false) -> StateMachStateComponent:
	for node in parent.get_children(recursive):
		if node is StateMachStateComponent:
			return node
	return null

static func get_state_mach_state_components(parent:Node, recursive:bool = false) -> Array[StateMachStateComponent]:
	var nodes:Array[StateMachStateComponent] = []
	for node in parent.get_children(recursive):
		if node is StateMachStateComponent:
			nodes.append(node)
	return nodes
