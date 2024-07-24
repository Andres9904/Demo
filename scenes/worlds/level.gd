extends Node2D

@export var _game_over_scene : PackedScene

@onready var _score_label := $UI/ScoreDisplay/ScoreLabel
@onready var _healthbar := $UI/HealthDisplay/Healthbar
@onready var _pause_ui := $UI/PauseUI
@onready var _countdown_label := $UI/PauseUI/CenterContainer/CountdownLabel
@onready var _start_countdown := $UI/PauseUI/CenterContainer/StartCountdown

var _start_countdown_time := 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_pause_game(true)
	_setup_score()
	_sub_player_events()
	_setup_healthbar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if _has_remaining_enemies():
		return
	_game_over()
	
func _setup_score() -> void:
	Global.score_change_event.connect(_on_score_change_event)
	Global.score = 0
	
func _sub_player_events() -> void:
	var player_health = HealthComponent.get_health_component($Player)
	player_health.health_change_event.connect(_on_player_health_change_event)
	player_health.health_became_zero_event.connect(_on_player_health_became_zero_event)

func _setup_healthbar() -> void:
	var player_health = HealthComponent.get_health_component($Player)
	_healthbar.min_value = 0
	_healthbar.max_value = player_health.maxHealth
	_healthbar.value = player_health.health

func _on_player_health_change_event(old_value:int, new_value:int) -> void:
	_healthbar.value = new_value
	
func _on_player_health_became_zero_event() -> void:
	_game_over()

func _has_remaining_enemies() -> bool:
	for node in get_children():
		if node is Enemy:
			return true
	return false

func _update_highscore() -> void:
	if Global.score > Global.high_score:
		Global.high_score = Global.score

func _game_over() -> void:
	_update_highscore()
	get_tree().change_scene_to_packed(_game_over_scene)

func _on_score_change_event(old_value:int, new_value:int) -> void:
	_score_label.text = "Score: " + str(new_value)
	
func _pause_game(pause:bool) -> void:
	if pause:
		get_tree().paused = true
		_pause_ui.visible = true
		_start_countdown_time = 3
		_update_countdown_label
		_start_countdown.start()
	else:
		get_tree().paused = false
		_pause_ui.visible = false

func _on_start_timer_timeout() -> void:
	_start_countdown_time -= 1
	_update_countdown_label()
	if _start_countdown_time > 0:
		return
	_pause_game(false)
	
func _update_countdown_label() -> void:
	_countdown_label.text = str(_start_countdown_time)

