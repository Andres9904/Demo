class_name Damagebox2DComponent extends Area2D

@export var damage := 1

signal deal_damage_event(damage:int, hitbox:Hitbox2DComponent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_on_area_entered)
	pass

func _on_area_entered(body: Node2D) -> void:
	if body is Hitbox2DComponent:
		body.takeDamage(damage, body)
		deal_damage_event.emit(damage, body)

static func get_damagebox2d_component(parent:Node, recursive:bool = false) -> Damagebox2DComponent:
	for node in parent.get_children(recursive):
		if node is Damagebox2DComponent:
			return node
	return null
