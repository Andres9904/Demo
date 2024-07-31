## An area 2D that represents an area that can deal damage to a hitbox
class_name Damagebox2DComponent extends Area2D

## The amount of damage that is dealt upon contact with a hitbox
@export var damage := 1

## A signal emitted when this damagebox deals damage to a hitbox
signal deal_damage_event(damage:int, hitbox:Hitbox2DComponent)

func _ready() -> void:
	# Subscribe to colliding with our areas
	area_entered.connect(_on_area_entered)
	pass

# Fired when this damage box hits another object
func _on_area_entered(body: Node2D) -> void:
	# Deal damage if we collided with a hitbox
	if body is Hitbox2DComponent:
		body.takeDamage(damage, body)
		deal_damage_event.emit(damage, body)

## Finds the first damagebox 2d component node of a parent
static func get_damagebox2d_component(parent:Node, recursive:bool = false) -> Damagebox2DComponent:
	for node in parent.get_children(recursive):
		if node is Damagebox2DComponent:
			return node
	return null
