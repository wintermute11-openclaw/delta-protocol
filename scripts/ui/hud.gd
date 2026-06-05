extends CanvasLayer

@onready var objective_label: Label = $MarginContainer/VBoxContainer/ObjectiveLabel
@onready var optional_label: Label = $MarginContainer/VBoxContainer/OptionalLabel
@onready var mission_status_label: Label = $MarginContainer/VBoxContainer/MissionStatusLabel
@onready var alarm_label: Label = $MarginContainer/VBoxContainer/AlarmLabel
@onready var weapon_label: Label = $MarginContainer/VBoxContainer/WeaponLabel
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var game_over_panel: ColorRect = $GameOverPanel
@onready var game_over_label: Label = $GameOverPanel/GameOverLabel
@onready var restart_label: Label = $GameOverPanel/RestartLabel

var player_ref: Node = null
var mission_manager: Node = null

func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group("player")
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	if GameState != null and GameState.has_signal("alarm_state_changed"):
		GameState.alarm_state_changed.connect(_on_alarm_state_changed)
	_connect_player_signals()
	_connect_mission_signals()
	game_over_panel.visible = false
	game_over_label.text = "MISSION FAILED"
	restart_label.text = "Press R to restart from checkpoint"
	_update_alarm_label()
	_update_player_labels()
	_update_mission_labels()

func _process(_delta: float) -> void:
	if player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player")
		_connect_player_signals()
	if mission_manager == null:
		mission_manager = get_tree().get_first_node_in_group("mission_manager")
		_connect_mission_signals()
	_update_player_labels()
	_update_mission_labels()
	_update_game_over_state()

func _connect_player_signals() -> void:
	if player_ref == null:
		return
	if player_ref.has_signal("player_died") and not player_ref.player_died.is_connected(_on_player_died):
		player_ref.player_died.connect(_on_player_died)
	if player_ref.has_signal("health_changed") and not player_ref.health_changed.is_connected(_on_health_changed):
		player_ref.health_changed.connect(_on_health_changed)

func _connect_mission_signals() -> void:
	if mission_manager == null:
		return
	if mission_manager.has_signal("mission_updated") and not mission_manager.mission_updated.is_connected(_on_mission_updated):
		mission_manager.mission_updated.connect(_on_mission_updated)
	if mission_manager.has_signal("mission_completed") and not mission_manager.mission_completed.is_connected(_on_mission_completed):
		mission_manager.mission_completed.connect(_on_mission_completed)

func _on_alarm_state_changed(_new_state: int, _reason: String) -> void:
	_update_alarm_label()

func _on_mission_updated() -> void:
	_update_mission_labels()

func _on_mission_completed() -> void:
	_update_mission_labels()

func _on_player_died() -> void:
	_update_game_over_state()

func _on_health_changed(_current_health: int, _max_health: int) -> void:
	_update_player_labels()

func _update_alarm_label() -> void:
	alarm_label.text = "Alarm: %s" % GameState.get_alarm_state_name()

func _update_player_labels() -> void:
	if player_ref == null:
		weapon_label.text = "Weapon: n/a"
		health_label.text = "Health: n/a"
		return

	if player_ref.has_method("get_weapon_status_text"):
		weapon_label.text = "Weapon: %s" % player_ref.get_weapon_status_text()
	if player_ref.has_method("get_health_status_text"):
		health_label.text = "Health: %s" % player_ref.get_health_status_text()

func _update_mission_labels() -> void:
	if mission_manager == null:
		objective_label.text = "Objective: n/a"
		optional_label.text = "Optional: n/a"
		mission_status_label.text = "Mission: n/a"
		return

	if mission_manager.has_method("get_objective_text"):
		objective_label.text = "Objective: %s" % mission_manager.get_objective_text()
	if mission_manager.has_method("get_optional_objective_text"):
		optional_label.text = "Optional: %s" % mission_manager.get_optional_objective_text()
	mission_status_label.text = "Mission: COMPLETE" if mission_manager.mission_complete else "Mission: ACTIVE"

func _update_game_over_state() -> void:
	var is_player_dead := false
	if player_ref != null and player_ref.has_method("is_alive"):
		is_player_dead = not player_ref.is_alive()
	game_over_panel.visible = is_player_dead
