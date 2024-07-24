extends Node

@export var score := 0:
	get:
		return score
	set(new_value):
		var old_score := score
		score = new_value
		score_change_event.emit(old_score, new_value)
		
@export var high_score := 0

@export var current_level:PackedScene = preload("res://scenes/worlds/level.tscn")

signal score_change_event(old_score, new_score)
