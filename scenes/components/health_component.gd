class_name HealthComponent extends Node2D

@export var maxHealth := 1
@export var health := 1:
	get:
		return health
	set(new_value):
		var old_value = health
		new_value = clamp(new_value, 0, maxHealth)
		health = new_value
		health_change_event.emit(old_value, new_value)
		if health == 0:
			health_became_zero_event.emit()

signal health_change_event(old_value:int, new_value:int)
signal health_became_zero_event

static func get_health_component(parent:Node, recursive:bool = false) -> HealthComponent:
	for node in parent.get_children(recursive):
		if node is HealthComponent:
			return node
	return null
