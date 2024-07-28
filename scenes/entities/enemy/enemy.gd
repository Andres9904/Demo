class_name Enemy extends Node2D

@export var velocity := Vector2()
@onready var _state_machine := $StateMachComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_health_became_zero_event() -> void:
	Global.score += 1
	queue_free()
