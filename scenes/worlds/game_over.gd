extends Control

@onready var _score_label := $CenterDisplay/ScoreLabel
@onready var _high_score_label := $CenterDisplay/HighScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_score_label.text = "Score: " + str(Global.score)
	_high_score_label.text = "High Score: " + str(Global.high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Input.is_action_just_pressed("start_game"):
		return
	get_tree().change_scene_to_packed(Global.current_level)
