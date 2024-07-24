class_name HitboxComponent extends Area2D

@export var _health_component:HealthComponent

signal damaged_event(damage:int, source)

func takeDamage(damage:int, source) -> void:
	if _health_component != null:
		_health_component.health -= damage
	damaged_event.emit(damage, source)

static func get_hitbox_component(parent:Node, recursive:bool = false) -> HitboxComponent:
	for node in parent.get_children(recursive):
		if node is HitboxComponent:
			return node
	return null
