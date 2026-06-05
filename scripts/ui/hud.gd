extends CanvasLayer

@onready var alarm_label: Label = $MarginContainer/VBoxContainer/AlarmLabel
@onready var weapon_label: Label = $MarginContainer/VBoxContainer/WeaponLabel
@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel

var player_ref: Node = null

func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group("player")
	if GameState != null and GameState.has_signal("alarm_state_changed"):
		GameState.alarm_state_changed.connect(_on_alarm_state_changed)
	_update_alarm_label()
	_update_player_labels()

func _process(_delta: float) -> void:
	if player_ref == null:
		player_ref = get_tree().get_first_node_in_group("player")
	_update_player_labels()

func _on_alarm_state_changed(_new_state: int, _reason: String) -> void:
	_update_alarm_label()

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
