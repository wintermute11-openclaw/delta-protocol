extends CanvasLayer

@onready var objective_label: Label = $MarginContainer/VBoxContainer/ObjectiveLabel
@onready var optional_label: Label = $MarginContainer/VBoxContainer/OptionalLabel
@onready var mission_status_label: Label = $MarginContainer/VBoxContainer/MissionStatusLabel
@onready var alarm_label: Label = $MarginContainer/VBoxContainer/AlarmLabel
@onready var weapon_label: Label = $MarginContainer/VBoxContainer/WeaponLabel
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel

var player_ref: Node = null
var mission_manager: Node = null

func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group("player")
	mission_manager = get_tree().get_first_node_in_group("mission_manager")
	if GameState != null and GameState.has_signal("alarm_state_changed"):
		GameState.alarm_state_changed.connect(_on_alarm_state_changed)
	if mission_manager != null and mission_manager.has_signal("mission_updated"):
		mission_manager.mission_updated.connect(_on_mission_updated)
	if mission_manager != null and mission_manager.has_signal("mission_completed"):
		mission_manager.mission_completed.connect(_on_mission_completed)
	_update_alarm_label()
	_update_player_labels()
	_update_mission_labels()

func _process(_delta: float) -> void:
	if player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player")
	if mission_manager == null:
		mission_manager = get_tree().get_first_node_in_group("mission_manager")
	_update_player_labels()
	_update_mission_labels()

func _on_alarm_state_changed(_new_state: int, _reason: String) -> void:
	_update_alarm_label()

func _on_mission_updated() -> void:
	_update_mission_labels()

func _on_mission_completed() -> void:
	_update_mission_labels()

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
